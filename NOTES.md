# Separation of concerns

One of the goals of Newton is to be quick to start (with no generators necessary) but easily scalable.

As such, as we evolve the implementation, some things to keep in mind.

## Outgrowing `use Newton`

The `use Newton` macro does a whole bunch of stuff:
1. Compiles templates
2. Defines the routes
3. Sets up the application/supervisor
  a. Sets up the Cowboy adapter

Each of these should be easily decomposed when needed.

For example, one may want to adopt a MVC pattern. That could be done by having `MyApp.Routes`, `MyApp.*Controller`, and perhaps even `MyApp.*Views`. This would mean:
1. `MyApp.Routes` is the central definition of routes, and also defines the supervision tree
2. `MyApp.*Views` would be in charge of compiling templates for a given directory under `templates/` and would be mostly optional
3. `MyApp.*Controller` would have convenience functions for either
  a. Compiling the relevant template itself and using it
  b. Easily calling the relevant view

We do not necessarily need to offer ready-made ways of doing this, but it should be simple enough for those who want this to do it.

## Handling template compilation and views

All templates by default are located in `templates/`. We want to compile them for maximum performance.

There are a couple ways of doing this.

### Compiling everything 

We can have a macro that simply globs `templates/*/**.eex` and compiles everything. It would need to do compilation depending on whether the file type is eex, html_eex, or html_heex.

Unfortunately, this means changing the compilation engine is not possible - but would this ever be done? I don't think so.

How do we handle the case where folks want to use their own `View` pattern?

One way would be to detect if there are any files in `views/`, but that seems hacky.

### Compiling via a `render` macro

Another way to do it is to make `render` a macro that uses the file name parameter know what specifically to compile. The disadvantage here is if one uses `render` in a more dynamic way, where the template to render is thus not knowable at compile time.

### "Compile" lazily at runtime

We could just compile the template on the first execution of it and then cache the result in an ETS table or something.

## Notes on the Phoenix View pattern

The Phoenix view pattern works as follows:
1. There is a View that corresponds to a given template directory
2. All the templates are compiled into that view
3. This makes all functions defined in the view available in the template, including imports



