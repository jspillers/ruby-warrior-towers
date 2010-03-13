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
      enemies[dir] = first_enemy_in_los_for_direction(dir)
    end

    sorted_enemies = enemies.sort do |a,b| 
      a_threat_lvl = a[1].nil? ? 0 : a[1].threat_level
      b_threat_lvl = b[1].nil? ? 0 : b[1].threat_level
      b_threat_lvl <=> a_threat_lvl 
    end

    # directions with no enemies in los are not a threat
    # delete directions with nil values
    sorted_enemies.delete_if {|k,v| v.nil?} 
    sorted_enemies.flatten.empty? ? [] : sorted_enemies
  end

  def first_enemy_in_los_for_direction(dir=nil)
    direction = dir || @current_direction

    look_array = @warrior.look(direction)

    nearest_enemy_space = look_array.detect {|s| s.enemy? }
    loc = look_array.index(nearest_enemy_space)

    if loc
      look_array[loc].unit if look_array[0..(loc-1)].all? {|s| s.empty? }
    end
  end

  def feel_archer?
    unless self.feel.empty? 
      self.feel.unit == RubyWarrior::Units::Archer
    end
  end

  def feel_wizard?
    unless self.feel.empty? 
      self.feel.unit == RubyWarrior::Units::Wizard
    end
  end

  def see_archer?
    !all_enemies_in_los.select {|e| e[1].class == RubyWarrior::Units::Archer }.empty?
  end

  def see_wizard?
    !all_enemies_in_los.select {|e| e[1].class == RubyWarrior::Units::Wizard }.empty?
  end

  def see_captive?
    captives = []
    Player::DIRS.each do |dir|
      look_array = @warrior.look(dir)
      nearest_captive_space = look_array.detect {|s| s.captive? }
      loc = look_array.index(nearest_captive_space)

      if loc && (loc == 0 || look_array[0..(loc-1)].all? {|s| s.empty? })
        captives << dir 
      end
    end

    captives
  end

end
