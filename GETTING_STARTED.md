# `mock-builder-fedora`

`mock-builder-fedora` is a docker container used by Lambda Linux Project to build and maintain RPMs for Fedora.

## Building `mock-builder-fedora` container

```
$ cd ~/mock-builder-fedora

$ docker build -t mock-builder-fedora:latest .
```

## Running `mock-builder-fedora` container

```
$ cd ~/mock-builder-fedora

$ docker run --rm --privileged=true -t -v `pwd`:/home/ll-user/mock-builder-fedora -i mock-builder-fedora /sbin/my_init -- /usr/bin/sudo -i -u ll-user
```

Once inside the container, set the `mock` environment

```
[ll-user@8012c2859b38] ~ $ source ~/mock-builder-fedora/bin/setenv
```

To build package

```
[ll-user@8012c2859b38] ~ $ mock --buildsrpm --scm-enable --scm-option package=<package_name> --scm-option branch=<branch_name>

[ll-user@8012c2859b38] ~ $ cd ~/mock-builder-fedora/builddir/fedora/build/SOURCES/; git fat init; git fat pull; cd ~/mock-builder-fedora/; mock --shell "chown -R mockbuild:mockbuild /builddir/build/SOURCES"

[ll-user@8012c2859b38] ~/mock-builder $ mock --rebuild <srpm_package>
[ll-user@8012c2859b38] ~/mock-builder $ mock --no-clean --rebuild <srpm_package>
```
