add_library('sound')
    
def average(lst): 
    return sum(lst) / len(lst) 

# The Flock (a list of Boid objects)
class Flock(object):

    def __init__(self):
        self.boids = []  # Initialize a list for all the boids.
    
    def run(self, ch_1, ch_2, w):
        for b in self.boids:
            # Pass the entire list of boids to each boid individually.
            b.run(self.boids)
        x_avg = self.get_x_avg()
        
        x_velocity_avg = self.get_x_velocity_avg()
        x_add = x_velocity_avg 
        
        y_velocity_avg = self.get_y_velocity_avg()
        y_add = y_velocity_avg 
        
        pos = (x_avg / w) * 2 - 1
        # Syntax: .set(freq, amp, add, pos)
        ch_1.set(x_avg, 1, x_velocity_avg, pos)
        y_avg = self.get_y_avg()
        ch_2.set(y_avg, 1, y_velocity_avg, pos)
    
    def addBoid(self, b):
        self.boids.append(b)
        
    def get_x_avg(self):
        return self.get_location_avg(0)
        
    def get_y_avg(self):
        return self.get_location_avg(1)
        
    def get_location_avg(self, index):
        location_list = [b.location[index] for b in self.boids]
        location_avg = average(location_list)
        
        return location_avg
    
    def get_x_velocity_avg(self):
        return self.get_velocity_avg(0)
    
    def get_y_velocity_avg(self):
        return self.get_velocity_avg(1)

    def get_velocity_avg(self, dim):
        velocity_list = [b.velocity[dim] for b in self.boids]
        velocity_avg = average(velocity_list)
        
        return velocity_avg
        
