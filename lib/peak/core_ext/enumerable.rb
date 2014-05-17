# Imported from http://stackoverflow.com/questions/7749568/how-can-i-do-standard-deviation-in-ruby
module Enumerable
  def sum
    self.inject(0){|accum, i| accum + i }
  end

  def mean
    self.sum/self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum +(i-m)**2 }
    sum/(self.length - 1).to_f
  end

  def std_dev
    return Math.sqrt(self.sample_variance)
  end
end
