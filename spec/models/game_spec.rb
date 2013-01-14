require 'spec_helper'

describe Game do
  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:image_url) }
end
