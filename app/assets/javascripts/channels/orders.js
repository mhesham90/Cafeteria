App.orders = App.cable.subscriptions.create("OrdersChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
      var order = JSON.parse(data.order);
      if (data.type === 'create') {
          var html = '<tr data-toggle="collapse" data-target="#'+order.id+'" class="clickable">'+
              '<td>'+order.created_at+'</td>'+
              '<td>'+order.user.first_name+'</td>'+
              '<td>'+order.user.room.name+'</td>'+
              '<td>'+order.notes+'</td>'+
              '<td>'+order.total +'</td>'+
              '<td>' +
              '<form class="edit_order" id="edit_order_'+order.id+'" action="/orders/'+order.id+'" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" >' +
              '<input type="hidden" name="_method" value="patch" /><input type="hidden" name="authenticity_token" value="'+$('meta[name=csrf-token]').attr('content')+'" />'+
              '<input type="submit" name="commit" value="process" class="btn btn-info" data-disable-with="process" />' +
              '<input class="hidden" style="width:100%" value="1" type="number" name="order[status]" id="order_status" />' +
              '</form></td>'+
              '</tr>'+
              '<tr><td colspan="5">'+
              '<div id="'+order.id+'" class="collapse">';

          order.orderdetails.forEach(function(ord){
                  html+= '<div class="col-md-4">' +
                      '<div class="card">'+
                      '<img src="https://res.cloudinary.com/cafeteria/image/upload/v1/products/'+ord.product.id+'/original/'+ord.product.avatar_file_name+'">' +
                      '<div class="card-block">'+
                      '<h3 class="card-title">'+ord.product.name+'</h3><hr>' +
                      '<p class="card-text"><B>price : </B><label>'+ord.product.price+'</label> LE' +
                      '<B style=" padding-left:5%">Quantity : </B><label>'+ ord.quantity+'</label>' +
                      '</div></div></div>'
              });

          html+= '</div></td></tr>';
          $('tbody').prepend(html);
      }
      else if (data.type === 'update') {
          if (order.status == 1){
              $('#table_46>tbody tr :eq(0)').text('processing')
              $('#table_46>tbody input').remove()
          }else{
              $('#table_46>tbody tr :eq(0)').text('out for delivery')
          }
      }
      else if (data.type === 'cancel') {
          var btn = '<button class="btn btn-danger cancelOrd">order canceled X</button>';
          $('form#edit_order_'+order.id).replaceWith(btn);
          $('.cancelOrd').on('click',function () {
              $(this).closest('tr').next().remove();
              $(this).closest('tr').remove();
          })

      }

          console.log(data)
  //    $('meta[name=csrf-token]').attr('content')
  }
});
