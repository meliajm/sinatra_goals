require './config/environment'

use Rack::MethodOverride # patch and delete

# use - for user controller and goal
use UsersController  #because we will use multiple controllers, one for users and one for goals

use GoalsController
run ApplicationController
