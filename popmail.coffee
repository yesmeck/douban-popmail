#
# Author: Meck <yesmeck@gmail.com>
#


jQuery ->
  @popbox = """
    <div id="more-mails" class="more-items">
      <div class="bd">
        <ul>
        </ul>
      </div>
      <div class="ft">
        <a href="http://www.douban.com/doumail/">查看全部邮件</a>
      </div>
    </div>
  """

  @mailLink = $('.top-nav-info a').first()
  @mailLink.parent().css('position', 'relative');
  @mailLink.click =>
    $.get('http://www.douban.com/doumail/', (res)->
      mails = []
      regex = /<table class="olt".+>[^]+<\/table>/gm
      match = regex.exec(res)
      table = $(match[0])
      table.find('tr').each((index, tr) ->
        if 0 < index < 6
          from = $(tr).find('td').eq(0).html()
          if $(from).find('a')
            from = $(from).html()
          else
            from = $(from).text()
          topic = $(tr).find('td').eq(2).html()
          time = $(tr).find('td').eq(3).html()
          mails.push(
            from: from,
            topic: topic,
            time: time
          )
      )
      $('#more-mails').find('ul').empty()
      $.each(mails, (index, mail)->
        $('#more-mails').find('ul').append("<li><div id='mail_notify_#{index}' class='item-req'>来之#{mail.from}的#{mail.topic} - #{mail.time}</div></li>")
      )
      $('#more-mails').find('ul a').attr('target', '_blank')
      $('#more-mails').toggle()
    )

    return false
  @mailLink.after(@popbox)

