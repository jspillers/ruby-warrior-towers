module SensoryExtension
  def feel
    @warrior.feel(@current_direction)
  end

  def look
    @warrior.look(@current_direction)
  end

  def nearest_enemy_space
    @warrior.look.detect {|s| s.enemy? }
  end

  def see_enemy?
    @warrior.look.any? {|s| s.enemy? }
  end

  def los_to_nearest_enemy?
    look_array = @warrior.look
    nearest_enemy_space = look_array.detect {|s| s.enemy? }
    loc = look_array.index(nearest_enemy_space)

    if loc
      if loc == 0 # enemy is in adjacent space
        false
      else
        look_array[0..(loc-1)].all? {|s| s.empty? }
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
    see_archer? && los_to_nearest_enemy?
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
    see_wizard? && los_to_nearest_enemy?
  end
end
