// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-ui/datepicker
//= require Chart.bundle.min
//= require_tree .

var App = function() {
  return {
    blockUI: function (el) {
      el.block({
        message: '',
        css: {
          backgroundColor: 'none'
        },
        overlayCSS: {
          backgroundColor: '#FFFFFF',
          backgroundImage: "url('/assets/ajax-loader.gif')",
          backgroundRepeat: 'no-repeat',
          backgroundPosition: 'center',
          opacity: 0.67
        }
      });
    },
    unBlockUI: function (el) {
      el.unblock();
    }
  }
}();


$(document).ready(function(){
  var location = null
  getLocation();

  $(document).on("click", ".weekly-report", function() {
    App.blockUI($("#chart-section"));
    var url = $(this).attr("data-href");

    $.ajax({
      type: "GET",
      url: url,
      data: { coords: location.coords },
      success: function(data) {
        App.unBlockUI($("#chart-section"));
        return false;
      },
      error: function(data) {
        App.unBlockUI($("#chart-section"));
        return false;
      }
    });
  });

  function renderData(date) {
    App.blockUI($("#report"));

    $.ajax({
      type: "GET",
      url: "/",
      data: { date: date, coords: location.coords },
      success: function(data) {
        App.unBlockUI($("#report"));
        renderMonthlyReport()
        return false;
      },
      error: function(data) {
        App.unBlockUI($("#report"));
        return false;
      }
    })
  }

  function getLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    }
  }

  function showPosition(position) {
    location = position;
    renderData(new Date().toLocaleString());
  }

  function renderMonthlyReport() {
    App.blockUI($("#daily_report"));

    $.ajax({
      type: "GET",
      url: "/weekly_report",
      data: { coords: location.coords },
      success: function(data) {
        App.unBlockUI($("#daily_report"));
        return false;
      },
      error: function(data) {
        App.unBlockUI($("#daily_report"));
        return false;
      }
    })
  }

  $(document).on("click", "#graph_view", function() {
    if($("#chart-section").css('display') == 'none') {
      App.blockUI($("#chart-section"));
      var url = $(this).attr("data-href");

      $.ajax({
        type: "GET",
        url: url,
        data: { coords: location.coords },
        success: function(data) {
          App.unBlockUI($("#chart-section"));
          return false;
        },
        error: function(data) {
          App.unBlockUI($("#chart-section"));
          return false;
        }
      });
    } else {
      $("#chart-section").hide("slow");
      $('html, body').animate({
        scrollTop: $(document).offset().top
      }, 2000);
    }
  });

  $(document).on("click", "#graph_hide_panel", function() {
    $("#chart-section").hide("slow");
  });
});
