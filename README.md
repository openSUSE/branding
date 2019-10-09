This repo is left intentionally blank in master branch.

If you want to work on branding for a new distribution, please
create a branch based on master, copy the artwork you want to base your
work on into it and then push it as new branch to github.

Do not rebase the history - the repository becomes too large otherwise
and we need to be able to deleted old branches at times.

-----------------------------------------------------------------------

Working with this repo in GitHub
------------------------------------

On github concepts: origin links to your forked repository and we
standardized the name of the original to upstream by convention.

First, create a fork of the repo, following this guide:
https://help.github.com/articles/fork-a-repo

Then clone your fork to your PC:

    git clone https://github.com/$YOUR_GITHUB_ACCOUNT/branding.git

and add the original repository as remote:

    cd branding
    git remote add upstream https://github.com/openSUSE/branding.git

Fetch the original content and checkout/merge the branch you want to work on:

    git fetch upstream
    git checkout -b leap-15.1
    git merge upstream leap-15.1

Now you can work with your local branch as you normally would.

To commit your changes to your fork, do:

    git commit -m "A useful description (eventually boo#NR) describing what changed"
(use -a if all the changes are relatives to the same commit)

    git push
This will update your repository fork.

Then you can create a pull request, as described here:
https://help.github.com/articles/creating-a-pull-request

If you want to sync with upstream changes, do a:

    git fetch upstream
    git merge upstream leap-15.1

(this is doing manually what git pull will do when set up)
