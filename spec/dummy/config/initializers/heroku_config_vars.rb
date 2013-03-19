HerokuConfigVars.authorize do
  params[:admin] != 'false'
end
