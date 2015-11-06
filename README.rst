==============================
 buildbot config for zerocash
==============================

This should have all of the config for our buildbot except secrets.

Deployment
==========

Deploy as follows:

#. clone (or pull an existing) repository on the host.
#. copy ``master.cfg`` *over* ``~bbmaster/buildbot/master.cfg``.
#. ensure ``~bbmaster/buildbot/master.cfg`` has the right owner/perms.
#. restart buildbot.
#. if there are problems with credentials it should hopefully show a
   helpful error banner. There's a lot of noise, look for ```***``` lines.
#. Fix those and any other outstanding issues.

Notice that any local changes to ``~bbmaster/buildbot/master.cfg`` will
be blown away, which is Right and Good, since they weren't in revision
control. ;-)

Perhaps someday we'll have a better deployment story.

Deployment Tests
================

You can experiment/test deployment to some degree with Docker. (on debian:
``apt-get install docker.io``)

.. code:: bash

   $ docker image build -t bbotzc .
   $ docker run bbotzc

At that point you can interactively experiment with the daemon, but note
it will have important differences from our production deployment.

