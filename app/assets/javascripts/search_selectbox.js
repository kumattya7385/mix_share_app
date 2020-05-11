$(document).on('turbolinks:load', function() {
  // プルダウンメニューを選択することでイベントが発生
  $('select.sort_order').change(function() {

    // 選択したoptionタグのvalue属性を取得する
    var this_value = $(this).val();
    // value属性の値により、ページ遷移先の分岐
    if (this_value == "new") {
      html = "&sort=new"
    } else if (this_value == "popular") {
      html = "&sort=popular"
    }  else {
      html = ""
    };
    // 現在の表示ページ
    var current_html = window.location.href;
    // ソート機能の重複防止 
    if (location['href'].match(/&sort=*.+/) != null) {
      var remove = location['href'].match(/&sort=*.+/)[0]
      var current_html = current_html.replace(remove, '')
    };
    // ページ遷移
    window.location.href = current_html + html
  });
  // ページ遷移後の挙動
  $(function () {
    if (location['href'].match(/&sort=*.+/) != null) {
      // option[selected: 'selected']を削除
      if ($('select option[selected=selected]')) {
        $('select option:first').prop('selected', false);
      }
      var selected_option = location['href'].match(/&sort=*.+/)[0].replace('&sort=', '');

      if(selected_option == "new") {
        var sort = 0
      } else if (selected_option == "popular") {
        var sort = 1
      }
      var add_selected = $('select.sort_order option').eq(sort)
      $(add_selected).attr('selected', true)
    }
  });
});