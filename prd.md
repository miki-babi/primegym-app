# 1. Product Vision

A localized fitness platform for Ethiopia that connects people with:

- Exercises and workout programs
- Nearby gyms
- Localized nutrition and meal plans
- Mealbox providers
- Trainers and fitness professionals
- Fitness communities
- Friends and accountability groups
- Challenges and gamification
- Local fitness businesses and events

The product should feel like:

**Strava + Google Maps + a workout app + a food marketplace + a social network**

but built specifically around local users, languages, gyms, foods, and communities.

---

# 2. Main Navigation

Use a 5-tab bottom navigation:

### Home

The user's daily fitness command center.

### Explore

Discover exercises, workouts, gyms, mealboxes, trainers, events and communities.

### Community

Friends, gym communities, groups, challenges and social feed.

### Activity

Workout history, progress, streaks, achievements and statistics.

### Profile

Goals, preferences, settings, subscriptions and personal fitness identity.

A prominent floating/central action can be:

**+ Start Workout**

---



# 3. Home Screen

The home screen should answer:

> "What should I do today?"



### Header

**Good evening, Miki 👋**

🔥 12 day streak

Profile picture + notifications

### Today's Goal

```text
TODAY

Chest + Triceps

0 / 1 workout

[ Start Workout ]
```



### Quick Actions

Four compact cards:

**Workout**

**Find Gym**

**Meal Plan**

**Check In**

### Social Activity

```text
YOUR PEOPLE

Abel     🟢 Training
Hana     ✅ Finished
Dawit    🟢 Training

[See community]
```



### Weekly Progress

```text
THIS WEEK

Workout
██████░░ 3 / 4

Nutrition
███████░ 6 / 7

Streak
🔥 12 days
```



### Nearby

```text
NEAR YOU

3 gyms
5 mealbox providers
2 fitness events
```

The user should be able to do something immediately without scrolling through statistics.

---



# 4. Onboarding Flow



## Step 1 — Welcome

```text
Build a healthier you.
With people around you.

[ Get Started ]
```



## Step 2 — Language

- English
- Amharic
- Afaan Oromoo
- More languages later

Allow language switching from settings.

## Step 3 — Goal

Select one or multiple:

- Build muscle
- Lose fat
- Gain weight
- Maintain
- Improve strength
- Improve fitness
- Improve endurance
- General health



## Step 4 — Experience

- Beginner
- Intermediate
- Advanced



## Step 5 — Training Location

- Gym
- Home
- Both
- Outdoor



## Step 6 — Equipment

- None
- Dumbbells
- Barbell
- Machines
- Resistance bands
- Full gym



## Step 7 — Fitness Preferences

Examples:

- Training days
- Preferred workout time
- Workout duration
- Favorite activities



## Step 8 — Nutrition

Ask:

- Nutrition goal
- Dietary preferences
- Foods they commonly eat
- Budget
- Meals per day



## Step 9 — Location Permission

Explain why:

> Find gyms, mealboxes, trainers and fitness events near you.



## Step 10 — Community

Ask:

> Want people to keep you accountable?

Options:

**Find friends**

**Join a community**

**Create a group**

## Step 11 — Personalized Plan

Generate:

**Your Fitness Plan**

Workout
Nutrition
Weekly goal
Nearby gyms
Recommended communities

Then enter Home.

---



# 5. Exercise Library

This should be one of the largest areas of the app.

## Exercise Categories

- Chest
- Back
- Shoulders
- Arms
- Legs
- Glutes
- Core
- Cardio
- Full body
- Mobility
- Stretching



## Filters

- Muscle
- Equipment
- Difficulty
- Goal
- Gym/home
- Duration



## Exercise Card

```text
[Exercise Video]

Barbell Bench Press

Chest • Compound • Intermediate

Equipment: Barbell

[ View Exercise ]
```



## Exercise Detail

Show:

- Video
- Exercise name
- Localized name
- Target muscles
- Secondary muscles
- Equipment
- Difficulty
- Instructions
- Common mistakes
- Safety notes
- Alternatives
- Progression
- Regression

Buttons:

**Add to Workout**

**Favorite**

**Watch Demo**

## Localization

Exercise content should support:

```text
exercise
exercise_translation
language
instructions
common_mistakes
```

Do not create separate exercise databases for each language.

---



# 6. Workout System



## Workout Discovery

Categories:

- Beginner
- Muscle gain
- Fat loss
- Strength
- Home
- Gym
- 15 minute
- 30 minute
- 45 minute
- 60 minute



## Workout Detail

```text
Push Day

45 min

Intermediate

Chest
Shoulders
Triceps

7 Exercises

[ Start Workout ]
```



## Active Workout Screen

Keep this extremely simple.

```text
Bench Press

Set 2 / 4

80 kg × 8

Previous:
75 kg × 8

[ − ]     80kg     [ + ]

[ Complete Set ]
```

After each set:

small haptic/visual confirmation.

At the end:

```text
WORKOUT COMPLETE 🎉

54 minutes
7 exercises
23 sets

+180 XP
🔥 Streak maintained

[ Share ]
[ Done ]
```

---



# 7. Workout Builder

Users can create:

**My Workout**

Add exercises.

Reorder exercises.

Set:

- Sets
- Reps
- Weight
- Rest
- Tempo
- Notes

Save as:

**Chest Day**

Then reuse it later.

---



# 8. Gym Discovery

Explore page:

```text
GYMS NEAR YOU

[ Search gyms ]

Map
────────────────

Power Fitness
1.2 km

⭐ 4.6
Open until 10 PM

🏋️ 24 people checked in today

[ View ]
```



## Map Mode

Show:

- Gyms
- Trainers
- Mealboxes
- Events



## Gym Detail

Header:

Large photo/video

**Power Fitness**

⭐ 4.6
1.2 km away

### Information

- Hours
- Membership price
- Equipment
- Amenities
- Classes
- Location
- Contact
- Photos



### Community

```text
POWER FITNESS COMMUNITY

327 members

34 active this week

🔥 September Challenge

[ Join Community ]
```



### Check In

Large primary button:

**Check In**

---



# 9. Gym Check-In

Possible methods:

### MVP

QR code at gym.

### Later

- GPS/geofence
- NFC
- Gym Wi-Fi verification

After check-in:

```text
You're in 💪

Power Fitness

Workout starts now.

[ Start Workout ]
```

Post automatically to friends only if enabled:

> Miki checked in at Power Fitness 🔥

---



# 10. Community

The Community tab is the social heart of the product.

## Feed

Post types:

### Workout

> Finished back day 💪



### Achievement

> New Bench PR: 90kg 🔥



### Check-in

> Just arrived at Power Fitness.



### Progress

Transformation photos.

### Question

> What do you do for lower back?



### Challenge

Challenge updates.

---



# 11. Social Reactions

Instead of only Likes:

- 🔥 Let's go
- 💪 Respect
- 👏 Proud of you
- ⚡ Keep pushing

This creates a supportive tone.

---



# 12. Friends

Users can:

- Follow
- Accept friend requests
- Message
- Invite to challenges
- Invite to accountability groups
- See shared activity

Privacy controls determine what is visible.

---



# 13. Accountability Groups

One of the core retention features.

Example:

## The Boys 💪

6 members

```text
Weekly goal:
4 workouts

Miki       3 / 4
Abel       4 / 4
Hana       4 / 4
Dawit      2 / 4
```

Features:

- Group chat
- Group feed
- Goals
- Streak
- Shared challenge
- Progress
- Reminders

---



# 14. Challenges



## Challenge Types



### Personal

30-Day Workout Challenge

### Friends

Train 4× this week

### Gym

Power Fitness September Challenge

### City

Addis Fitness Challenge

### Community

1000 workout challenge

## Challenge Screen

```text
SEPTEMBER CHALLENGE

82 participants

You: #7

████████░░ 80%

24 / 30 workouts
```

Show:

- Ranking
- Progress
- Participants
- Posts
- Milestones

---



# 15. Gamification

Use XP.

### XP Actions

Workout completed
+50 XP

Complete weekly goal
+200 XP

Challenge completed
+500 XP

Help another member
+30 XP

Maintain streak
+150 XP

## Levels

Example:

Beginner → Regular → Consistent → Athlete → Elite → Legend

Don't base levels only on strength.

Reward:

**Consistency + improvement + participation**

---



# 16. Achievements

Examples:

🏋️ First Workout

🔥 7 Day Streak

🔥 30 Day Streak

💪 100 Workouts

🏆 First Challenge

🤝 Community Builder

👑 1 Year Fitness

Achievements appear on profiles.

---



# 17. Fitness Profile

The profile should feel like a person's fitness identity.

```text
Miki

🔥 12 day streak

🏋️ 87 workouts

🎯 Muscle Gain

📍 Power Fitness

Level 18

14 achievements
```

Tabs:

**Posts**

**Workouts**

**Progress**

**Achievements**

**Communities**

---



# 18. Progress Tracking

Track:

- Weight
- Body measurements
- Workout volume
- Strength
- Workout frequency
- Streak
- Goals

Allow progress photos.

### Example

```text
BENCH PRESS

60kg
  ↓
90kg

+50%
```

Charts should be visually simple.

---



# 19. Nutrition System

Nutrition should have its own major section.

## Meal Plans

Goals:

- Muscle gain
- Fat loss
- Maintenance
- Weight gain
- General health



## User Preferences

- Budget
- Meal frequency
- Dietary restrictions
- Foods
- Cooking ability
- Calories
- Protein target

---



# 20. Local Meal Plans

Use locally familiar foods rather than copying Western bodybuilding menus.

Example:

### Muscle Gain — Week 1

Breakfast:

- Eggs
- Injera
- Shiro
- Milk

Lunch:

- Rice
- Chicken
- Vegetables

Snack:

- Yogurt
- Fruit
- Peanuts

Dinner:

- Injera
- Tibs
- Vegetables

Every meal should show:

- Approximate calories
- Protein
- Carbs
- Fat
- Cost estimate

Nutrition numbers should be presented as estimates, not medical prescriptions.

---



# 21. Mealbox Marketplace

Explore:

**Mealbox near me**

Filters:

- Goal
- Price
- Distance
- Calories
- Protein
- Delivery
- Pickup
- Subscription



## Provider Profile

```text
FitMeal Addis

⭐ 4.7

Muscle Gain
Fat Loss
Healthy Meals

Weekly plans

5 meals     1,500 ETB
10 meals    2,800 ETB
20 meals    5,000 ETB

[ View Plans ]
```

---



# 22. Mealbox Subscription

User chooses:

**Goal**

**Meals per week**

**Pickup or delivery**

**Preferred branch**

**Start date**

Then:

```text
YOUR PLAN

Monday    ✅
Tuesday   ✅
Wednesday Skip
Thursday  ✅
Friday    ✅

[ Manage Subscription ]
```

Useful features:

- Skip day
- Pause
- Resume
- Change plan
- Payment history
- Pickup history
- Coupons
- Renewal reminders

---



# 23. Trainers

Trainer profiles:

- Photo
- Name
- Specialization
- Experience
- Gym
- Rating
- Programs
- Availability
- Price

Actions:

**Follow**

**Book**

**View Programs**

---



# 24. Fitness Events

Events:

- Gym competitions
- Group runs
- Fitness classes
- Workshops
- Challenges
- Bodybuilding events

Event page:

```text
Saturday Run

📍 Addis Ababa
🗓 Saturday, 7:00 AM

104 attending

[ Join Event ]
```

---



# 25. Search

Global search should understand:

- Exercises
- Gyms
- Mealboxes
- Trainers
- Communities
- Users
- Challenges
- Events

Example:

Search:

> "chest"

Results:

Exercises
Workouts
Trainers
Posts

---



# 26. Notifications

Keep notifications useful.

### Social

> Abel reacted to your workout.



### Accountability

> You haven't trained today.



### Gym

> 18 people from your community checked in.



### Challenge

> Hana moved ahead of you.



### Nutrition

> Your mealbox subscription renews tomorrow.



### Achievement

> You reached a 14-day streak 🔥

Allow users to control each category.

---



# 27. Messaging

MVP:

- Direct messages
- Group messages

Later:

- Gym communities
- Trainer-client chat
- Meal provider communication

Avoid turning the whole application into another generic messenger.

Messaging exists to support fitness relationships.

---



# 28. Explore Screen

Make Explore the discovery engine.

```text
EXPLORE

[ Search ]

Nearby
────────────

🏋️ Gyms

🍛 Mealboxes

👨‍🏫 Trainers

🏃 Events

🔥 Challenges

👥 Communities

────────────

Popular exercises

Recommended workouts

Trending in Addis
```

---



# 29. Business Side

Have a separate **Business Portal**.

Business types:

- Gym
- Mealbox provider
- Trainer
- Nutritionist
- Event organizer
- Fitness store

Business dashboard:

### Overview

- Views
- Leads
- Bookings
- Check-ins
- Followers
- Revenue



### Gym

Manage:

- Profile
- Photos
- Equipment
- Memberships
- Classes
- Community
- Challenges
- QR check-in



### Mealbox

Manage:

- Meals
- Plans
- Pricing
- Availability
- Orders
- Subscribers



### Trainer

Manage:

- Profile
- Programs
- Clients
- Schedule
- Bookings

---



# 30. Admin Platform

Admin should manage:

### Users

- Accounts
- Reports
- Moderation
- Suspensions



### Exercises

- Exercise creation
- Translations
- Videos
- Muscle groups



### Nutrition

- Foods
- Meal plans
- Nutrition data
- Local food database



### Businesses

- Gyms
- Trainers
- Meal providers



### Communities

- Reports
- Moderation



### Challenges

- Global challenges
- Featured challenges



### Content

- Articles
- Educational content
- Announcements



### Localization

Admin should be able to manage translations.

---



# 31. User Flow — First-Time User

```text
Download
 ↓
Language
 ↓
Create account
 ↓
Fitness goal
 ↓
Experience
 ↓
Training preferences
 ↓
Nutrition preferences
 ↓
Location
 ↓
Recommended gyms
 ↓
Recommended workouts
 ↓
Recommended meal plan
 ↓
Recommended communities
 ↓
Home
```

The user should reach a useful personalized experience in a few minutes.

---



# 32. User Flow — Workout

```text
Home
 ↓
Start Workout
 ↓
Choose workout
 ↓
Exercise 1
 ↓
Set
 ↓
Complete
 ↓
Exercise 2
 ↓
...
 ↓
Workout Complete
 ↓
XP + Streak
 ↓
Share / Community
 ↓
Home
```

---



# 33. User Flow — Find Gym

```text
Explore
 ↓
Gyms
 ↓
Nearby map
 ↓
Select gym
 ↓
Gym profile
 ↓
See equipment/community
 ↓
Join gym community
 ↓
Get directions
 ↓
Arrive
 ↓
QR check-in
 ↓
Start workout
```

---



# 34. User Flow — Mealbox

```text
Explore
 ↓
Mealboxes
 ↓
Nearby providers
 ↓
Provider
 ↓
Choose goal
 ↓
Choose plan
 ↓
Pickup / Delivery
 ↓
Subscribe
 ↓
Payment
 ↓
Meal schedule
 ↓
Receive meals
 ↓
Track subscription
```

---



# 35. User Flow — Accountability

```text
Profile / Community
 ↓
Create group
 ↓
Invite friends
 ↓
Choose goal
 ↓
Set weekly target
 ↓
Members train
 ↓
Check-ins recorded
 ↓
Group progress
 ↓
Streak maintained
 ↓
Challenge completed
```

---



# 36. UI Design Direction

The interface should feel:

**Energetic + modern + social + local**

Avoid making it look like a medical health app.

### Visual hierarchy

Large:

- Workout action
- Check-in
- Goal
- Progress

Medium:

- Social activity
- Challenges
- Nearby recommendations

Small:

- Secondary statistics



### Cards

Use rounded cards but don't put everything inside cards.

Use full-width sections for the most important actions.

### Typography

Use a highly readable typeface with strong support for:

- Latin
- Amharic
- Afaan Oromoo

Localization must be considered from the beginning because text lengths can vary significantly.

---



# 37. Important Mobile UX Rules



### One-handed use

Primary actions should be reachable with the thumb.

### Workout mode

Keep the screen awake.

Large buttons.

Minimal distractions.

### Offline

Workout logging should work without internet.

Sync when connection returns.

### Weak network

Compress videos and images.

Use thumbnails first.

Lazy-load large media.

This is especially important for local users with inconsistent connectivity.

---



# 38. Home Personalization

The home screen should change based on what the user is doing.

### Beginner

More education and guidance.

### Experienced lifter

More performance and workout tracking.

### Social user

More communities and challenges.

### Nutrition-focused user

More meal plans and mealboxes.

The product should feel personalized rather than displaying the same dashboard to everybody.

---



# 39. Safety & Privacy

Users should control:

- Who sees workouts
- Who sees check-ins
- Who sees body measurements
- Who sees progress photos
- Who can message them
- Who can follow them

Location should never expose a user's exact location publicly.

Gym check-ins should show the gym, not the user's precise GPS position.

---



# 40. MVP Scope

Do NOT build everything at once.

## Phase 1



### Core

- Authentication
- Localization
- User profiles
- Goals
- Exercise library
- Workout tracking
- Workout builder
- Basic progress tracking



### Social

- Friends
- Feed
- Reactions
- Accountability groups
- Streaks
- Challenges



### Discovery

- Gyms
- Nearby search
- Gym profiles
- Gym communities
- Check-in



### Nutrition

- Local food database
- Basic meal plans
- Mealbox listings

This is already a strong MVP.

---



# 41. Phase 2

Add:

- Mealbox subscriptions
- Trainer marketplace
- Gym business dashboard
- Events
- Advanced challenges
- Messaging
- Trainer programs
- Payments
- Reviews
- Business analytics

---



# 42. Phase 3

Add:

- AI workout generation
- AI meal planning
- Personalized recommendations
- Computer-vision exercise feedback
- Wearable integration
- Advanced fitness analytics
- Fitness competitions
- Corporate wellness
- More Ethiopian languages
- Regional expansion

---



# 43. The Core Product Loop

The entire product should repeatedly drive this:

```text
DISCOVER
   ↓
CHOOSE A GOAL
   ↓
GET A PLAN
   ↓
WORK OUT
   ↓
CHECK IN
   ↓
EARN XP
   ↓
SHARE PROGRESS
   ↓
GET SOCIAL SUPPORT
   ↓
COMPETE / COMPLETE CHALLENGE
   ↓
EAT / FOLLOW MEAL PLAN
   ↓
RETURN TOMORROW
```

The most important insight is that **exercise is not the product by itself**.

Exercise is the starting point.

The real product is the connection between:

**Workout + Gym + Food + People + Accountability + Progress.**

That gives you a platform where a user can discover a gym, follow a workout in Amharic, check in, meet people, join a challenge, order a local mealbox, track progress, and build a fitness identity without leaving the app.