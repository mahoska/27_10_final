<template>
<div class="showOrders">
  
  <div class="row">
    <div  class="col-sm-12 col-md-12">
      <div class="ord_err">{{isOrd}}</div>
      <div class="err_info">{{errEdit}}</div>
      <div class="add_info">{{isEdit}}</div>
      <table class="table table-bordered cart-table">
        <tr>
          <th>№</th>
          <th>Date create</th>
          <th>Client</th>
          <th>Client discount</th>
          <th>Payment</th>
          <th>Total sum</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </table>
      <div class="panel-group" id="accordion"  style="position:relative"  >
        <div class="panel panel-default " v-for="order in orders" :key="order.id">
          <table class="table table-bordered cart-table">
            <tr>
                <td data-toggle="collapse" data-parent="#accordion" :href="'#'+order.id"  @click="showOrder(order.id)">{{order.id}}</td>
                <td>{{order.date_order_create}}</td>
                <td>{{order.client}}</td>
                <td>{{order.discount_client}}</td>
                <td>{{order.payment}}</td>
                <td>{{order.total_price}}</td>
                <td>
                   <select v-model="order.status_id" class="form-control" >
                      <option v-for="status in statuses" :value="status.id" :key="status.id">
                        {{status.name}}
                      </option>
                    </select>
                </td>
                <td>
                  <button  class="btn btn-primary btn-sm" @click="changeStatus(order.id, order.status_id)">Change<br> Status</button>
                </td>
            </tr>
          </table>
          <div :id="order.id" class="panel-collapse collapse">
            <div class="panel-body">
              <div v-if="!orderItem.length">
                we do not have information on this order
              </div>
              <table class="simple"  v-if="orderItem.length">
                <tr>
                  <th>Book name</th>
                  <th>Count</th>
                  <th>Price</th>
                  <th>Discount</th>
                </tr>
                <tr v-for="record in orderItem" :key="record.book_id">
                  <td>{{record.name}}</td>
                  <td>{{record.count}}</td>
                  <td>{{record.book_price}}</td>
                  <td>{{record.discount_book}}</td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'showOrders',
  data () {
    return {
      orders: [],
      isOrd: "",
      orderItem: [],
      isEmptyOrd: "",
      statuses: [],
      errEdit: "",
      isEdit: ""
    }
  },
  created(){
    this.getOrders()
    this.$emit('clearSelect')
  },
  methods:{
    getOrders(){
       var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/status/', this.config)
    //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/status/', this.config)
      .then(function (response) {
        //console.log(response.data.data)
        self.statuses = response.data.data 
      })
      .catch(function (error) {})    

     axios.get('http://localhost:88/BOOK_SHOP/client/api/order/', this.config)
    //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/order/', this.config)
      .then(function (response) {
        console.log(response.data.data)
        self.orders = response.data.data 
      })
      .catch(function (error) {})
    },

    showOrder(order_id){
        var self = this
        axios.get('http://localhost:88/BOOK_SHOP/client/api/fullinfoorder/'+ order_id, this.config)
        //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/fullinfoorder/'+  order_id, this.config)
          .then(function (response) {
            self.orderItem = response.data.data
          })
          .catch(function (error) {
          })
        },

    changeStatus(order_id, status_order){
      var self = this
      //axios.put('http://192.168.0.15/~user15/BOOK_SHOP/client/api/order/', 
      axios.put('http://localhost:88/BOOK_SHOP/client/api/order/', 
      {
        status_id: status_order,
         id: order_id
      }, this.config)
      .then(function (response) {
        if(response.data.data == '1'){
          self.isEdit = "record was updeted."
          setTimeout(function () {
              self.isEdit = ""
          },2500);
        self.getOrders()
      }
      })
      .catch(function (error) {
        self.errEdit = "somthing wrong, no update was made"
        setTimeout(function () {
            self.errEdit = ""
        },2500);
      });

        }

      },

    
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.order{
  margin: 50px auto;
  min-height: 500px;
}
table {
			font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
      margin: 0px auto;
			font-size: 14px;
			background: white;
      color: black;
			max-width: 100%;
			width: 100%;
			border-collapse: collapse;
			
			/*background: url("../assets/blurry.jpg") no-repeat;*/
			/*background-position: 100% 55px;*/
		}
    th {
		  font-weight: normal;
		  color: #339;
		  padding: 10px 12px;
      text-align: left;
      width: 12%;
		}
		td {
		 background-image: url("/static/back.png");
		 filter:alpha(opacity=60);
		 opacity:0.6;
		 color:#000028;
		  border-top: 1px solid white;
		  padding: 10px 12px;
      width: 12%;
      cursor: pointer;
      text-align: left;
      font-size: 12px;
		}

    table.simple td  {
      cursor: default;
    }

  .ord_err{
    font-weight: bold;
    font-size: 17px;
    position: relative;
    color: #F00;
  }

</style>
