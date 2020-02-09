require './config/environment'

use Rack::MethodOverride # because we will use multiple controllers, one for users and one for goals

# use - for user controller and goal
use UsersController
use GoalsController
run ApplicationController
