#!/bin/bash

PIDFILE=1234

haproxy_start(){
  echo "haproxy started"
}
haproxy_stop(){
  echo "haproxy stoped"
}
haproxy_reload(){
  echo "haproxy reload success"
}
haproxy_restart()
{
  haproxy_stop
  haproxy_start
}
haproxy_status(){
  echo 'running pid '  $PIDFILE
}


case "$1" in
start)
  echo "Starting haproxy" "haproxy"
  haproxy_start
  ret=$?
  case "$ret" in
  0)
    echo 0
    ;;
  1)
    echo 1
    echo "pid file '$PIDFILE' found, haproxy not started."
    ;;
  2)
    echo 1
    ;;
  esac
  exit $ret
  ;;
stop)
  echo "Stopping haproxy" "haproxy"
  haproxy_stop
  ret=$?
  case "$ret" in
  0|1)
    echo 0
    ;;
  2)
    echo 1
    ;;
  esac
  exit $ret
  ;;
reload|force-reload)
  echo "Reloading haproxy" "haproxy"
  haproxy_reload
  case "$?" in
  0|1)
    echo 0
    ;;
  2)
    echo 1
    ;;
  esac
  ;;
restart)
  log_daemon_msg "Restarting haproxy" "haproxy"
  haproxy_stop
  haproxy_start
  case "$?" in
  0)
    echo 0
    ;;
  1)
    echo 1
    ;;
  2)
    echo 1
    ;;
  esac
  ;;
status)
  haproxy_status
  ret=$?
  case "$ret" in
  0)
    echo "haproxy is running."
    ;;
  1)
    echo "haproxy dead, but $PIDFILE exists."
    ;;
  *)
    echo "haproxy not running."
    ;;
  esac
  exit $ret
  ;;
*)
  echo "Usage: /etc/init.d/haproxy {start|stop|reload|restart|status}"
  exit 2
  ;;
esac

:

