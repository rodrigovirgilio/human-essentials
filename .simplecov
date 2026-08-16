SimpleCov.start 'rails' do
  enable_coverage :branch
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/db/'
  add_filter '/lib/tasks/'
end
