# 3D Treasure Island Game – Godot Engine

A 3D first-person treasure hunt game developed in Godot. The player explores a park, collects hidden items, and races against time to reach the goal.

---

## Game Description

This is a 3D treasure hunt game set in a park environment. The player must collect enough points (75) within a 75-second time limit.  
There are 3 types of items:

- **Coins** – 2 points each  
- **Chests** – 5 points each  
- **Diamonds** – 10 points each  

Items are scattered and hidden in various park objects such as treehouses and playgrounds.

---

## Special Features

- Stores **top 5 high scores** in a local JSON file and displays them after each session or via the main menu
- Includes a **reset scores** button
- Displays real-time status of points and remaining item counts during gameplay
- Ability to **quit** to main menu mid-game

---

## Unique Environment

The 3D park is built from multiple models joined and positioned on a textured terrain (plane mesh with grass texture).  
Textures include **albedo**, **metallic**, and **roughness** layers for realism.

---

## Scenes Overview

### Main Menu (`main_menu.tscn`)

- Built using 2D nodes: `TextureRect`, `Sprite2D`, `Label`, and Buttons
- Logo created in Photoshop
- Background music via `AudioStreamPlayer`
- Scene transitions handled using button signals and `main_menu.gd`
- Cursor visibility and music setup handled in `_ready()`

### Global Script (`Global.gd`)

- Stores game score, score list, and path to a JSON file
- Functions:
  - `load_scores()`: Loads scores if JSON exists, else creates it
  - `save_scores()`: Writes top 5 scores
  - `add_score()`: Adds and sorts a new score
  - `reset_scores()`: Resets score list

---

## Park Scene (`ttterain.tscn`)

- Ground: `MeshInstance3D` with `StaticBody` and `CollisionShape`, using custom grass texture (Poly Haven)
- Multiple imported 3D models (trees, benches, houses, playgrounds)
- Custom 3D collisions created using "Create Collision Shape" for each model
- Added sky, light, shadows, fog, and post-processing for lighting effects
- Overlay displays score, time, and item count
- `Time.gd` handles countdown and triggers end scene after 75 seconds
- `ttterain.gd` checks score in `_process()`. If score reaches 75, moves to end screen

---

## Player Controller (`player.tscn`)

- Built with `CharacterBody3D`, `Camera3D`, mesh, and collider
- First-person movement
- `player.gd` handles:
  - Real-time updates of score and item counts
  - Input mapping for movement and jump
  - `increase_score()` and `counter()` update global score and label info
  - `ready()`: Stores initial orientation
  - `physics_process()`: Movement and physics
  - `rotate_look()`: Mouse-based camera movement
  - `capture_mouse()`: Toggles cursor visibility

---

## Score Screen (`scores.tscn`)

- Similar to main menu but includes a dark transparent overlay (`ColorRect`)
- Uses a custom shader to apply Gaussian blur to the background
- `scores.gd` loads scores from `Global.gd` and renders them
- Reset button is connected to the `reset_scores()` function

---

## Item Scenes

Each item (Coin, Chest, Diamond) has:

- Its own scene and script: `coin.tscn`, `chest.tscn`, `diamond.tscn`
- Structure:
  - `Area3D` with `MeshInstance3D` and `CollisionShape3D`
  - Optional: Sound effect on collection
- Functionality:
  - Rotates each frame
  - `on_body_entered()`:
    - Plays sound
    - Hides item and disables collider
    - Calls `increase_score()` and `counter()` in `player.gd` to update UI

---

## End Screen (`end_screen.tscn`)

- Reuses score overlay with adjusted text
- Shows result, top scores, and buttons for replay or return to menu
- Text such as "You Won!" is conditionally updated in script
- Uses global functions to retrieve and display scores


