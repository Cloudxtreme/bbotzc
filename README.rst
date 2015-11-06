==============================
 buildbot config for zerocash
==============================

This should have all of the config for our buildbot except secrets.

Deployment
==========

For deploying updates, this works for many changes (esp. only to ``master.cfg``):

#. On ``ci.leastauthority.com`` become the user ``bbmaster``. The
   following steps all assume that user.
#. ``cd ~/bbotzc ; git pull --ff-only ; cd ~``
#. ``cp ./bbotzc/master.cfg ./buildbot/master.cfg``.
#. ``buildbot restart ./buildbot``

Other changes may require more complicated deployment, eg if they:
change dependencies, require altering the buildslave in some manner,
introduce/move credentials files, add more files besides ``master.cfg``...

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

