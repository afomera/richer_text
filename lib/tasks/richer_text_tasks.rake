desc "Installs RicherText into your application"
task "richer_text:install" do
  Rails::Command.invoke :generate, ["richer_text:install"]
end
