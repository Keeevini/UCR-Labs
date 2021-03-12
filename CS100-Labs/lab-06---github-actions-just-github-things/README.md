# Continuous Integration (CI)
In a previous lab we learned how to use GTest to write unit tests for our code. This is a very powerful skill to ensure that we don't break something in our code as we develop and that we can write code that lives up to specification. We have also discussed Test Driven Development (TDD) which has us write the tests to the specification first, then write enough code to pass the test before moving on. Now, this all works great, but we'd love a way to (1) test our code automatically when we make changes and (2) not **let** us break our own code, or our teammates'. Much of what becoming a more efficient programmer is is learning how to prevent yourself from making the little errors that cause big problems later on. This is where **continuous integration** comes in. Continuous integration (CI) is a development practice where developers integrate code into a shared repository frequently and each integration is *verified* by an automated build and automated tests. This will let you catch errors early and not commit code that does not pass the current tests, or even breaks past tests (regression testing). 

There exist many tools to perform continuous integration and I suggest you start working with [Travis CI](https://travis-ci.org/) in your own projects. The reason I suggest Travis CI is because it comes with the GitHub Student Developer Pack so it's free for you to use (to an extent). It's always a good idea to look into different tools as your next internship/job may use a different one. The process is similar across many of them. 

Unfortunately, you need owner permissions to add Travis CI and so you won't be able to add it to the repositories in this course since we are the owners of those repositories. Instead, we will be using GitHub actions to create our own continuous integration *workflow*. 

## GitHub Actions
>GitHub Actions make it easy to automate all your software workflows, now with world-class CI/CD. Build, test, and deploy your code right from GitHub. Make code reviews, branch management, and issue triaging the way you want. - [GitHub](https://github.com/features/actions)

There are many great workflows that already exist that you can use to get started. I suggest you explore them during, or after, the quarter and think how you could use them in your personal projects. We're going to make our own flow from scratch. It's always good to learn how to create something from scratch first.

### Getting started
 * In the top bar, click on the "Actions" button.
 * Click on "set up a workflow yourself ->"

Now what you'll see is that GitHub has created a file `main.yml` in `<Repo-name>/.github/workflows/`. This is a YAML file (rhymes with *camel*) and is used typically as a configuration file. GitHub Actions use it to describe the workflow. Let's take a look at each aspect of this file:

First, you can name the workflow. The default name happens to be CI which is what we're doing so we can leave that.
```
name: CI
```

Next, let's specify when the actions will run:
```
on:
  push:
    branches: [ main ]
  pull_requests:
    branches: [ main ]
```
Your workflow will now run every time you *push* or make a *pull request* to your **main** branch only. These are the *triggering events*. 

Now let's look at *what* will be done on each of those *triggering events*:
```
# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps: 
    # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
    - uses: actions/checkout@v2

    # Runs a single command using the runners shell
    - name: Run a one-line script
      run: echo Hello, world!

    # Runs a set of commands using the runners shell
    - name: Run a multi-line script
      run: |
        echo Add other actions to build,
        echo test, and deploy your project.
```
This is a good start. It won't do anything that we will want it to do eventually, but it provides output and we'll be able to see something happening. It's always a good idea to run a "Hello world!" type of program when first learning a language, tool, or framework. In the top right corner you'll see a "Start commit" button. It is typically **not** a good practice to do commits directly to the *main* branch and from the GitHub interface but it's okay for small changes in files like the `README.md` and in this case since we are just initializing the default. We'll work from the command line after this. Let's create a commit message
```
Create main.yml
 * Leave the defaults in the YAML file
 ```
 And commit. 

 Now if you go to the `<> Code` tab (and to the top level directory) you'll see that you made a commit and you'll see a small green check mark next to the commit hash. If you see a yellow dot instead just be patient, your actions are still running. You may need to refresh the page a few times. If you see a red X, your actions are failing, talk to the TA because something has gone wrong. The green check indicates that your commit is **passing** your CI tests. This is easy to do since you don't actually have any tests yet. Let's check out specifically what is happening. If you click on the check mark you can see a popup that shows the checks that are being run, their status and a button to see more details. You can click on that button or you can click on the `Actions` tab in the top bar to go to the main actions page. Let's click on the `details` button to see what happened. This will take us to a more detailed page on what was run. We can see that we successfully (green check mark) `Set up job`, `Run actions/checkout@v2`, `Run a one-line script`, `Run a multi-line script`, `Post Run actions/checkout@v2`, `Complete job` and each one has an arrow to the left to expand more details about that specific step. The middle 3 `Run ...` actions should be familiar, those are the steps that you wrote under `jobs...build` in the YAML file. The `Post Run ...` and `Complete job` are generated automatically (though you can add details) by the GitHub Actions engine. Let's expand the `Run a one-line script` section
```
1  > Run echo Hello, world!
4  Hello, world!
```
and expand the `Run a multi-line script` sectiona
```
1  > Run echo Add other actions to build,
5  Add other actions to build,
6  test, and deploy your project. 
```
and we can see the output of our commands as well as the command that was run.

Now, it's bad practice to commit directly on GitHub and to commit directly to the *main* branch so let's setup the Actions to run on a different branch and complete developing on it. Log in to **Hammer** and navigate to where you have been keeping your CS100 labs. Clone the repo you've been working on (`git clone ...`) and create a new branch to work on.
```
git checkout -b <netid>/ci_setup
```

Our actions won't run on this branch though, so we'll need to make sure we add this branch to the list of branches that will trigger the actions:
```
on:
  push:
    branches: [ main, <netid>/ci_setup ]
  pull_request:
    branches: [ main ]
```
Pushes to `main` and `<netid>/ci_setup` will now trigger the actions but only pull requests on the `main` branch will trigger the actions. Commit and push your new branch to GitHub and switch to that branch on the web interface (top left of directories). Click on the green check next to the commit hash and go to more details. If you open the section on `Run actions/checkout@v2` and then expand the subsection `Checking out the ref` you should see something along the lines of:
```
/usr/bin/git checkout --progress --force -B <netid>/ci_setup refs/remotes/origin/<netid>/ci_setup
```
This indicates that you are running the actions on your `<netid>/ci_setup` branch. You can peruse the other sections, but you should see that they are still passing exactly the same way. 

## Lab exercises
Now that you know the basics of working with GitHub Actions and YAML configuration files, your task is to get your tests to now run through GitHub Actions and give you a **green check** when they are passing, but, just as importantly, a **red X** when they are failing. It is *always* a good idea to make sure that you can get your tests to fail. If you can't, they likely aren't working properly. 

You are going to extend the `Rectangle` class from the first lab (which only had an `area` function) and add some functionality:
 * Add a constructor that accepts a width and height as parameters (`Rectangle(int,int)`)
 * Add a `perimeter()` function that will return the perimeter of the rectangle

With this added functionality you should create three **test suites**, one for each of:
 * Constructors
 * Area
 * Perimeter

And add tests to each test suite to properly test each function. This will probably require ~3 - 6 tests per suite.

### Deliverables
You should have a branch `<netid>/passing_tests` and `<netid>/failing_tests` in your repository and they should be passing (green check) and failing (red X) respectively. The YAML file and test files should be identical between these two branches, the only difference should be in the `Rectangle` source code that you have written. **Don't** change the *expected* results of the tests to create a failure. You do not need to fail **every** test, or even every suite, but you should be able explain what you did to cause the failure. 

You will need to show each of these branches to your TA and discuss (1) your YAML file, (2) the tests you wrote and (3) the process to merge one of the branches into your `main` branch. Once you have done this, and the TA is satisfied you understand the concepts, they will sign off on the lab.

If you need help on the GitHub actions syntax you can reference their documentation [here](https://docs.github.com/en/actions/reference)

Hints:
 * The easiest way to make a test fail is to remove the implementation of a function and just hard code an (incorrect) return value.
 * To add googletest as a submodule: `git submodule add https://github.com/google/googletest.git`
   * Don't forget, if you have a submodule in the repository, you need to clone by `git clone --recursive ...`
 * Learn how to use the [actions/checkout](https://github.com/actions/checkout) process to mimic your own build process. 

 Once you have finished the lab you can add a badge to the README.md. From the actions page, go to the workflow you just created. In the upper right you should see a button that says `Create status badge`. You can add that to the top of your README.md and you'll get a badge that shows the current status of your workflow *on your main branch*. This isn't required for the lab but can be helpful in your other projects.
