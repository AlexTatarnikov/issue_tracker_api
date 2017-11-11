SimpleCov.profiles.define 'issue_tracker_api' do
  load_profile 'test_frameworks'

  add_filter '/config/'
  add_filter '/db/'
  add_filter '/app/serializers/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'

  track_files '{app,lib}/**/*.rb'
end
