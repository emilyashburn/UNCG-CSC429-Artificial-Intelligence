
% Enable fact to be asserted by program:
:- dynamic fact(1).

% Define operators used in if-then rules:
:- op(800,fx,if).
:- op(700,xfx,then).
:- op(300,xfy,or).
:- op(200,xfy,and).

% Sample KB:

fact(a).

if a then b.

if b then c.

