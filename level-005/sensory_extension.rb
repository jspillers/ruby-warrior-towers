module SensoryExtension
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

  def feel_wizard?
    unless self.feel.empty? 
      self.feel.unit == RubyWarrior::Units::Wizard
    end
  end
end
