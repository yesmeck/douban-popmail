#
# Author: Meck <yesmeck@gmail.com>
#


jQuery ->
  @popbox = """
    <div id="more-mails" class="more-items">
      <div class="bd">
        <p id="mail-loading" style="display: none;">邮件读取中...</p>
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
    $('#mail-loading').show();
    $('#more-mails').find('ul').empty()
    $('#more-mails').toggle()
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
      $('#mail-loading').hide();
      $.each(mails, (index, mail)->
        $('#more-mails').find('ul').append("<li><div id='mail_notify_#{index}' class='item-req'>来之#{mail.from}的#{mail.topic} - #{mail.time}</div></li>")
      )
      $('#more-mails').find('ul a').attr('target', '_blank')
    )

    return false
  @mailLink.after(@popbox)

