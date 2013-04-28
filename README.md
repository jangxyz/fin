
# `fin` - a growly finale for bash 

`fin` is a bash script over [growlnotify](http://growl.info/downloads), to get notified when your lengthy job on terminal has finished.

With `fin` you can shamelessly continue browsing your facebook while your computer is doing hardwork. `fin` will tell you when your job is over, how it was finished (exit code). Plus, you would get a nice smiley :) on successful exit rather than just plain code 0.

![fin screenshot](http://jangxyz.github.io/fin/screenshot.png Image Here)

Really, you could do all this with just using `growlnotify`. But I think `./do_some_job; fin` is much better than `./do_some_job; growlnotify -t 'what' -m "uh.. yeah here's what you've got: $? "`. Don't you?

`fin` is clever enough not to overwrite the exit code. It will exit with the same exit code it has received, so you can do more bash scripting afterwards.


### Install ###

0. Install `growl` and `growlnotify`. This is a prerequisite.
1. Copy `fin` executable to any directory in path, such as $HOME/bin
2. Add alias to your `.bashrc`. This makes your life easier.

	alias fin='$HOME/bin/fin $?'


### Usage ###

```
usage: fin exitcode [options]

options:
    -t|--title                : title (default 'done')
    -m[Z]|--message[-nonzero] : message to print [only when return code is non-zero]
    -s[Z]|--sticky[-nonzero]  : stick. [only when return code is non-zero]

```


### Example ###

Using the `fin` executable:

```
$ ls
$ $HOME/bin/fin $?
```


But with the `fin` alias, life gets even easier!

```
$ git clone https://github.com/jangxyz/fin.git
$ fin
```

Note you can just add it directly when writing the command in the first place.

```
$ git clone https://github.com/jangxyz/fin.git; fin
```


To keep the notification _stick_ - let's say you need to rush to the toilet, and later come back and just see how it went

```
$ git clone https://github.com/jangxyz/fin.git
$ fin -s 
```

Don't like the title?

```
$ git clone https://github.com/jangxyz/fin.git
$ fin -t 'Now get to work'
```

Or the message

```
$ git clone https://github.com/jangxyz/fin.git
$ fin -m 'Look, it was kinda hard for me to do all the work..'
```

How about if you only want it to stick on nonzero exit codes?

```
$ git clone https://github.com/jangxyz/fin.git
$ fin -sZ
```

Note you have `-mZ` option as well.


