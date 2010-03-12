module SensoryExtension
  def feel(dir=nil)
    @warrior.feel(dir || @current_direction)
  end

  def look(dir=nil)
    @warrior.look(dir || @current_direction)
  end

  def nearest_enemy_space
    @warrior.look.detect {|s| s.enemy? }
  end

  def see_enemy?
    @warrior.look.any? {|s| s.enemy? }
  end

  def all_enemies_in_los
    enemies = {}
    Player::DIRS.each do |dir|
      enemies[dir] = first_enemy_in_los(dir)
    end
    enemies
  end

  def sorted_threats
    res = all_enemies_in_los.sort do |a,b| 
      a_threat_lvl = a[1].nil? ? 0 : a[1].threat_level
      b_threat_lvl = b[1].nil? ? 0 : b[1].threat_level
      b_threat_lvl <=> a_threat_lvl 
    end

    # directions with no enemies in los are not a threat
    # delete directions with nil values
    res.delete_if {|k,v| v.nil?} 
    res.flatten.empty? ? nil : res
  end

  def first_enemy_in_los(dir=nil)
    direction = dir || @current_direction

    look_array = @warrior.look(direction)

    nearest_enemy_space = look_array.detect {|s| s.enemy? }
    loc = look_array.index(nearest_enemy_space)

    if loc
      if loc == 0 # enemy is in adjacent space
        nil
      else
        return look_array[loc].unit if look_array[0..(loc-1)].all? {|s| s.empty? }
      end
    end
  end

  def feel_sludge?
    unless self.feel.empty? 
      self.feel.unit == RubyWarrior::Units::Sludge || self.feel.unit == RubyWarrior::Units::ThickSludge
    end
  end

  def feel_archer?
    unless self.feel.empty? 
      self.feel.unit == RubyWarrior::Units::Archer
    end
  end

  def see_archer?
    nearest_enemy_space.unit == RubyWarrior::Units::Archer if nearest_enemy_space
  end

  def los_to_archer?
    see_archer? && first_enemy_in_los
  end

  def feel_wizard?
    unless self.feel.empty? 
      self.feel.unit == RubyWarrior::Units::Wizard
    end
  end

  def see_wizard?
    nearest_enemy_space.unit == RubyWarrior::Units::Wizard if nearest_enemy_space
  end

  def los_to_wizard?
    see_wizard? && first_enemy_in_los
  end
end
