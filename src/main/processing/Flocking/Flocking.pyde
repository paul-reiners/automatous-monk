"""
Flocking
by Daniel Shiffman.

An implementation of Craig Reynold's Boids program to simulate
the flocking behavior of birds. Each boid steers itself based on
rules of avoidance, alignment, and coherence.

Click the mouse to add a boid.
"""

from boid import Boid
from flock import Flock

flock = Flock()

def setup():
    size(640, 360)
    # Add an initial set of boids into the system
    for i in range(80):
        flock.addBoid(Boid(width / 2, height / 2))
    # Create the sine oscillator.
    global ch_1, ch_2
    ch_1 = Pulse(this)
    ch_1.play(0,1)
    ch_2 = Pulse(this)
    ch_2.play(0,1)

def draw():
    background(50)
    flock.run(ch_1, ch_2, width, height)

# Add a boid into the System
def mousePressed():
    flock.addBoid(Boid(mouseX, mouseY))
