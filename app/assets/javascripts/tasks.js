document.addEventListener("turbolinks:load", function() {
  // セレクトボックス変更時にsubmitする
  $('.edit_detail').change(function(){
    $(this).closest("form").submit();
  });


  // submit時にタスク内容が空だったら、エラーメッセージを表示
  $('#new_detail').submit(function() {
    $value = $('#detail_content').val().replace(/\s/g, "")
    if ($value === "") {
      $('#hidden').show();
      return false;
    } else {
      $('#hidden').hide();
    }
  });

  // 予定日を入力が入力されていなかったら、checkboxをdisabledに
  var check_disabled = function() {
    if ($('#task_scheduled_date').val() === "") {
      $('#task_send_mail').prop('disabled', true);
    } else {
      $('#task_send_mail').prop('disabled', false);
    }
  }

  // 最初はdisabled
  check_disabled();

  // 予定日を変更したときに関数呼び出し
  $('#task_scheduled_date').change(function() {
    check_disabled();
  });

  // 予定日を過ぎていた場合はエラーメッセージを表示、予定日が変更されたら、checkboxにチェックを入れる
  $('#task_scheduled_date').change(function() {
    var $dataval = $('#task_scheduled_date').val();
    var today = new Date();
    var schedule_date = new Date($dataval);
    if (dateComparison(today, schedule_date)) {
      $('#hidden').show();
    } else {
      $('#hidden').hide();
    }
    $('#task_send_mail').prop("checked",true);
  });

  var dateComparison = function(today, schedule_date) {
    var todayYear = today.getFullYear();
    var todayMonth = today.getMonth() + 1;
    var todayDay = today.getDate();
    var schedule_dateYear = schedule_date.getFullYear();
    var schedule_dateMonth = schedule_date.getMonth() + 1;
    var schedule_dateDay = schedule_date.getDate();
    if (todayYear == schedule_dateYear) {
      if (todayMonth == schedule_dateMonth) {
          return todayDay > schedule_dateDay;
      }
      else {
          return todayMonth > schedule_dateMonth;
      }
    } else {
        return todayYear > schedule_dateYear;
    }

  };
});