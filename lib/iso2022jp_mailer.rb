# -*- coding: utf-8 -*-
require 'nkf'
class Iso2022jpMailer < ActionMailer::Base
  @@default_charset = 'iso-2022-jp'
  @@encode_subject  = false

  # utility method for base64 encode on subject.
  # taken from http://wiki.fdiary.net/rails/?ActionMailer
  def base64(text, charset="iso-2022-jp", convert=true)
    if convert
      if charset == "iso-2022-jp"
        text = NKF.nkf('-j -m0', text)
      end
    end
    text = [text].pack('m').delete("\r\n")
    "=?#{charset}?B?#{text}?="
  end

  def mail_with_iso2022jp(headers = {}, &block)
    mail = mail_without_iso2022jp(headers, &block)
    mail.body = NKF.nkf('-j', mail.body.raw_source)
    mail.charset = 'ISO-2022-JP'
    mail
  end

  alias_method_chain :mail, :iso2022jp
end
