# Imported from http://stackoverflow.com/questions/7749568/how-can-i-do-standard-deviation-in-ruby
module Enumerable
  def sum
    inject(0){|accum, i| accum + i }
  end

  def mean
    sum/length.to_f
  end

  def sample_variance
    m = mean
    sum = inject(0){|accum, i| accum + (i-m)**2 }
    sum/(length - 1).to_f
  end

  def std_dev
    Math.sqrt(sample_variance)
  end
end
