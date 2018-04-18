describe kernel_module('parport') do
  it { should be_loaded }
end

describe kernel_module('lp') do
  it { should be_loaded }
end

describe kernel_module('appletalk') do
  it { should be_blacklisted }
end

describe kernel_module('l2tp_ppp') do
  it { should_not be_loaded }
end

describe kernel_module('atm') do
  it { should_not be_loaded }
end
