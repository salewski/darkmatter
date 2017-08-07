;;; eval.lisp
;;-*- coding:utf-8 -*-

;;; Copyright (c) Eddie.
;;; Distributed under the terms of the MIT License.

(in-package :cl-user)
(defpackage darkmatter.eval
  (:use :cl :darkmatter.eval.rpc)
  (:export :start))
(in-package :darkmatter.eval)

(defvar *server* (jsonrpc:make-server))

(mapcar
  #'(lambda (rpcdef)
      (jsonrpc:expose *server*
                      (car rpcdef)
                      (cdr rpcdef)))
  +rpcdef-list+)

(defun start ()
  (jsonrpc:server-listen *server* :mode :websocket))
