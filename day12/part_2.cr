class Moon
  property :position_x, :position_y, :position_z
  property :velocity_x, :velocity_y, :velocity_z

  def initialize(@id : Int32, x : Int32, y : Int32, z : Int32)
    @position_x = x
    @position_y = y
    @position_z = z
    @velocity_x = 0
    @velocity_y = 0
    @velocity_z = 0
  end

  def dump
    position_x.to_s +
      position_y.to_s +
      position_z.to_s +
      velocity_x.to_s +
      velocity_y.to_s +
      velocity_z.to_s
  end

  def energy
    (position_x.abs + position_y.abs + position_z.abs) *
      (velocity_x.abs + velocity_y.abs + velocity_z.abs)
  end
end

class Universe
  property :moons

  def initialize(@moons = [] of Moon)
    @iterations = 0
    @history = [] of String
  end

  def calculate(times : Int64 = 10000000000000)
    times.times do
      p @iterations
      moons.combinations(2).each do |pair|
        apply_gravity(pair)
      end
      apply_velocity

      dump = dump_moons
      if @history.includes? dump
        return @iterations
      else
        @history << dump
        @iterations += 1
      end
    end

    calculate_energy
  end

  def apply_gravity(pair)
    moon_a = pair[0]
    moon_b = pair[1]

    if moon_a.position_x > moon_b.position_x
      moon_a.velocity_x = moon_a.velocity_x - 1
      moon_b.velocity_x = moon_b.velocity_x + 1
    elsif moon_a.position_x < moon_b.position_x
      moon_a.velocity_x = moon_a.velocity_x + 1
      moon_b.velocity_x = moon_b.velocity_x - 1
    end

    if moon_a.position_y > moon_b.position_y
      moon_a.velocity_y -= 1
      moon_b.velocity_y += 1
    elsif moon_a.position_y < moon_b.position_y
      moon_a.velocity_y += 1
      moon_b.velocity_y -= 1
    end

    if moon_a.position_z > moon_b.position_z
      moon_a.velocity_z -= 1
      moon_b.velocity_z += 1
    elsif moon_a.position_z < moon_b.position_z
      moon_a.velocity_z += 1
      moon_b.velocity_z -= 1
    end
  end

  def dump_moons
    moons.map do |moon|
      moon.dump
    end.join
  end

  def apply_velocity
    moons.each do |moon|
      moon.position_x += moon.velocity_x
      moon.position_y += moon.velocity_y
      moon.position_z += moon.velocity_z
    end
  end

  def calculate_energy
    energy = 0
    moons.each do |moon|
      energy += moon.energy
    end

    energy
  end
end

uni = Universe.new
uni.moons << Moon.new(1, -7, 17, -11)
uni.moons << Moon.new(2, 9, 12, 5)
uni.moons << Moon.new(3, -9, 0, -4)
uni.moons << Moon.new(4, 4, 6, 0)

# uni.moons << Moon.new(1, -1, 0, 2)
# uni.moons << Moon.new(2, 2, -10, -7)
# uni.moons << Moon.new(3, 4, -8, 8)
# uni.moons << Moon.new(4, 3, 5, -1)

p uni.calculate
