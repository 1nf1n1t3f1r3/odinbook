# This file is now safe for production! It will NEVER delete real users or real posts.

# -------------------------
# 🔐 PERSISTENT USERS
# -------------------------
test_email = "guest@example.com"
main_email = "1nf1n1t3f1r3@gmail.com"

# Ensure your main persistent users exist safely
main_user = User.find_or_create_by!(email: main_email) do |u|
  u.username = "Janus"
  u.password = "password"
end

test_user = User.find_or_create_by!(email: test_email) do |u|
  u.username = "Guest"
  u.password = "guest@example.com"
end


# Map each character name directly to their custom messages array
character_feed = {
  "Odin One-Eye" => [
    "I trade an eye for wisdom, yet I still can't find where I left my SSH keys.",
    "The ravens Huginn and Muninn are monitoring this network. Keep it clean.",
    "Who touched my spear? It was calibrated perfectly."
  ],
  "Techno Thor" => [
    "ANOTHER BUG SQUASHED WITH THE MJÖLNIR COMPILER! ⚡",
    "Bring me more coffee, or feel the wrath of my thunderous deploy script!",
    "Is it just me, or does Loki's code smell like a trick?"
  ],
  "Loki the Bugfix" => [
    "It's not a bug, it's an undocumented magical feature.",
    "I just pushed directly to production. Let the chaos begin. 🐍",
    "Who blamed me for the server downtime? I was nowhere near the datacenter."
  ],
  "Ragnarok Runetime" => [
    "The world is ending. The stack trace is infinitely long.",
    "System memory is overflowing. Fenrir has slipped his chains!"
  ],
  "Valkyrie Coder" => [
    "Guiding dead servers straight to Valhalla today.",
    "An honorable deploy is a successful deploy."
  ],
  "Paladin of Twijfelachtige Keuzes" => [
    "Hey @Gorrmoth the Necromancer, is that offer still open?",
    "Smite first, read the documentation later."
  ],
  "Orc Ranger" => [
    "..."
  ],
  "Garritt the Goatherd" => [
    "Has anybody seen my Goat?"
  ],
  "Nebril Chosk" => [
    "Limited time offer! Now selling Statuettes of Waukeen for 5 Gold! Guaranteed good luck for 1 week, maybe 2! Get yours today!",
    "No refunds on the statuettes. Waukeen's blessings are non-negotiable."
  ],
  "Gorrmoth the Necromancer" => [
    "Help Wanted. All bodies welcome. No experience needed. Good pay."
  ],
  "Aubrey Silverspun" => [
    "Unfortunately, Aubrey's Peculiarities Shop remains closed until further notice. Magical Containment Wards will continue to operate; please refrain from touching anything."
  ]
}

dummy_users = []

puts "Checking and ensuring thematic dummy users exist..."

character_feed.each do |username, messages|
  # Fix the email: Downcase it, turn spaces into underscores, and keep it safe for Devise
  safe_email = "#{username.downcase.gsub(' ', '_')}@example.com"

  dummy_users << User.find_or_create_by!(email: safe_email) do |u|
    u.username = username
    u.password = "password"
  end
end

all_seed_users = dummy_users + [ main_user, test_user ]

# -------------------------
# 📝 POSTS (Custom In-Jokes)
# -------------------------
target_post_count = 25
current_count = Post.count

if current_count < target_post_count
  # Calculate exactly how many posts we need to create to hit our target
  posts_needed = target_post_count - current_count
  puts "🌱 Creating #{posts_needed} dynamic character posts to hit our target of #{target_post_count}..."

  # Using an explicit integer loop guarantees it runs exactly the right amount of times
  posts_needed.times do
    random_user = dummy_users.sample
    phrase_pool = character_feed[random_user.username]
    random_message = phrase_pool.sample
    random_time = rand(1..700).hours.ago

    post = Post.create!(
      content: random_message,
      user: random_user,
      created_at: random_time,
      updated_at: random_time
    )

    # 4. Add random comments
    rand(1..2).times do
      Comment.create!(
        content: [ "Haha amazing", "Classic.", "Wait, really?", "👍", "What is happening here?" ].sample,
        user: all_seed_users.sample,
        post: post,
        created_at: random_time + rand(1..30).minutes
      )
    end

    # 5. Add random likes
    all_seed_users.sample(rand(1..5)).each do |liker|
      Like.find_or_create_by!(user: liker, post: post)
    end
  end

  puts "✅ Seeds finished! Total posts now in database: #{Post.count}"
else
  puts "⏭️ Skipping dummy post generation because the feed already has #{current_count} posts."
end


# Ensure some base network connections exist between seed users
all_seed_users.each do |user|
  (all_seed_users - [ user ]).sample(rand(1..3)).each do |other_user|
    Follow.find_or_create_by!(follower: user, followed: other_user)
  end
end

# Make sure YOU follow test_user and vice versa
Follow.find_or_create_by!(follower: main_user, followed: test_user)
Follow.find_or_create_by!(follower: test_user, followed: main_user)

# -------------------------
# 🎯 COUNTER CACHE REFRESH
# -------------------------
# CRITICAL step: Forces Rails to recalculate likes_count and comments_count
# for every single post. Without this, your hot_score SQL math will see 0.
puts "🔄 Recalculating database counter caches..."
Post.find_each do |p|
  Post.reset_counters(p.id, :likes, :comments)
end

puts "✅ Seeds processed safely!"
