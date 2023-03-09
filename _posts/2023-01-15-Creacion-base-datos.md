layout: single
title: Creacion de la base de datos con SQL
excerpt: En este documento se redacta la creacion de la base de datos con el lenguaje de TRANSAC-SQL
date: 2023-01-23
classes: wide
header:
  teaser: /assets/images/htb-writeup-frolic/frolic_logo.png
categories:
  - SQL SERVER 2019
  - Windows
tags:  
  - metasploit
  - esoteric language
  - ctf
  - rop
  - buffer overflow
  - binary exploitation
---

![](/assets/images/htb-writeup-frolic/frolic_logo.png)

Frolic had a pretty straightforward user access part where after minimal enumeration we could find the password for the PlaySMS application obfuscated a couple of times with some esoteric languages and other things. The PlaySMS application which we could access with the password was directly exploitable from Metasploit without any effort.

The priv esc had a buffer overflow in a SUID binary that we had to exploit using a ROP gadget from the libc library. I discovered the very cool [one_gadget](https://github.com/david942j/one_gadget) tool while doing this box.

## Quick summary

- PlaySMS is installed and vulnerable to a bug which we can exploit with Metasploit (needs to be authenticated)
- The credentials for PlaySMS are found in an encrypted zip file, which is encoded in Brainfuck, obfuscated in some random directory, then further obfuscated with Ook esoteric programming language
- The priv esc is a SUID binary which we can ROP with one_gadget (ASLR is disabled)

### Tools used
