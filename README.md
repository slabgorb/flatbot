# Flatbot

This is a version of GitHub's Campfire bot, hubot, customized for Flat World Knowledge.

This version is designed to be deployed on [Heroku][heroku]. Flatbot is on heroku at http://flatbot.herokuapp.com/ but you won't find any web presence.

[heroku]: http://www.heroku.com

### Testing Flatbot Locally

You can test flatbot by running the following. Note that we use the Flowdock adapter.

    % bin/hubot -a flowdock -n flatbot

You'll see some start up output about where your scripts come from and a
prompt.

    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading adapter shell
    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading scripts from /home/tomb/Development/hubot/scripts
    [Sun, 04 Dec 2011 18:41:11 GMT] INFO Loading scripts from /home/tomb/Development/hubot/src/scripts
    Hubot>

Then you can interact with flatbot by typing `flatbot help`.

    Hubot> flatbot help

    Hubot> animate me <query> - The same thing as `image me`, except adds a few
    convert me <expression> to <units> - Convert expression to given units.
    help - Displays all of the help commands that Hubot knows about.
    ...


### Scripting

Take a look at the scripts in the `./scripts` folder for examples.
Delete any scripts you think are useless or boring.  Add whatever functionality you
want flatbot to have. Read up on what you can do with hubot in the [Scripting Guide](https://github.com/github/hubot/blob/master/docs/scripting.md).

### Redis Persistence

If you are going to use the `redis-brain.coffee` script from `hubot-scripts`
(strongly suggested), you will need to add the Redis to Go addon on Heroku which requires a verified
account or you can create an account at [Redis to Go][redistogo] and manually
set the `REDISTOGO_URL` variable.

    % heroku config:add REDISTOGO_URL="..."

If you don't require any persistence feel free to remove the
`redis-brain.coffee` from `hubot-scripts.json` and you don't need to worry
about redis at all.

[redistogo]: https://redistogo.com/

We use the persistence with Flatbot (why not?), so you'll need to run a redis-server locally if you want to test locally.

## hubot-scripts

There will inevitably be functionality that everyone will want. Instead
of adding it to hubot itself, you can submit pull requests to
[hubot-scripts][hubot-scripts].

To enable scripts from the hubot-scripts package, add the script name with
extension as a double quoted string to the `hubot-scripts.json` file in this
repo.

[hubot-scripts]: https://github.com/github/hubot-scripts

## external-scripts

Tired of waiting for your script to be merged into `hubot-scripts`? Want to
maintain the repository and package yourself? Then this added functionality
maybe for you!

Hubot is now able to load scripts from third-party `npm` packages! To enable
this functionality you can follow the following steps.

1. Add the packages as dependencies into your `package.json`
2. `npm install` to make sure those packages are installed

To enable third-party scripts that you've added you will need to add the package
name as a double quoted string to the `external-scripts.json` file in this repo.

## Deployment

You'll need to have access to the flatbot heroku instance, and add it as a remote:

    % heroku git:remote -a flatbot

Then:

    % git push heroku master
    % heroku ps:scale web=1

If you run into any problems, checkout Heroku's [docs][heroku-node-docs].

More detailed documentation can be found on the
[deploying hubot onto Heroku][deploy-heroku] wiki page.

[heroku-node-docs]: http://devcenter.heroku.com/articles/node-js
[deploy-heroku]: https://github.com/github/hubot/blob/master/docs/deploying/heroku.md
[deploy-unix]: https://github.com/github/hubot/blob/master/docs/deploying/unix.md
[deploy-windows]: https://github.com/github/hubot/blob/master/docs/deploying/unix.md

## Restart the bot

You may want to get comfortable with `heroku logs` and `heroku restart`
if you're having issues.
