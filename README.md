# A runc playground

Want to play with runc? Here's a place to do it.

```
vagrant up
vagrant ssh
```

Then, inside the vagrant box:

```
sudo su
mkdir -p /some/container
cd /some/container
runc spec
```

This will generate a default config. The default config won't work however.
You'll need to make a couple of minor changes:

```
vim config.json
```

Change the rootfs line to point to `/vagrant/rootfs`. At the very least, you'll
want your rootfs to exist. The one provided in the `/vagrant/` directory is a
busybox image which will allow you to actually run things and look around
inside.

```
vim runtime.json
```

The default specs are set up to exercise a feature called seccomp, which on
this vagrant box is not compiled in. So you'll want to remove the following
section from `runtime.json`:

```
"seccomp": {
                "defaultAction": "SCMP_ACT_ALLOW",
                "architectures": null,
                "syscalls": []
        },
        "rootfsPropagation": ""
}
```

...just delete it.

After that, you should be able to run:

```
runc start
```

...and you'll get a shell inside the container.
