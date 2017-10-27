<template>
  <div class="editclient">
    <div class="err_info">{{errEdit}}</div>
    <div class="add_info">{{isEdit}}</div>
    <div class="add" v-if="client_show">
      <div class="lbl_add">Client(id:{{client_id}}) edit form:</div>
        <div  class="form-group">
          <label for="name">First name</label>
          <input type="text" class="form-control" id="name"  placeholder="name" v-model.trim="client.name"  @blur="check_name">
        </div>
        <div  class="form-group">
          <label for="sname">Last name</label>
          <input type="text" class="form-control" id="sname" placeholder="last name" v-model.trim="client.surname"  @blur="check_name">
        </div>
        <div  class="form-group">
          <label for="email">Email</label>
          <input type="email" class="form-control" id="email"  placeholder="email" v-model.trim="client.email" @blur="check_email">
        </div>
        <div  class="form-group">
          <label for="phone">Phone</label>
          <input type="text" class="form-control" id="phone" placeholder="phone" v-model.trim="client.phone" @blur="check_phone">
        </div>
        <div  class="form-group">
          <label for="login">Login</label>
          <input type="text" class="form-control" id="login"  placeholder="login" v-model.trim="client.login">
        </div>
        <div  class="form-group">
          <label for="password">Password</label>
          <input type="password" class="form-control" id="password" placeholder="enter password if you want change it" v-model.trim="client.password" >
        </div>
        
        <div class="row">
          <div  class="col-sm-10 col-md-5">
            <div class="form-group">
              <label for="inputDiscount">Discount</label>
              <input type="number" min='0' step='0.1' class="form-control" id="inputDiscount"  v-model="client.discount">
            </div>
          </div>
        <div  class="col-sm-2 col-md-2"></div>
        <div  class="col-sm-10 col-md-5">
          <div class="checkbox">
            <label>
              <input type="checkbox"  v-model.trim="client.disable" >Disable
            </label>
          </div>
        </div>     
      </div>
        <button  class="btn btn-primary" @click="edit_client">Edit client</button>
        <button class="btn btn-cans"@click="cancel">Cancel</button> 
      </div>
  </div>

</template>

<script>
import axios from 'axios'
export default {
  name: 'editClient',
  data () {
    return {
      client: {},
      errEdit: "",
      isEdit: "",
      client_show: true
    }
  },
  created(){
    this.$emit('clearSelect')
  },
  methods:{

    cancel(){
      this.$emit('clearSelect')
      this.$router.push({path: '/admin'})
  },

   edit_client(){   
      if (this.check_phone()  && this.check_email() && this.check_name() && this.check_login()) {
			if(this.client.login==""|| this.client.name=="" || this.client.surname=="" || this.client.phone=="" || this.client.email==""){
				this.errEdit = "not all fields are filled";
        setTimeout(function () {
              this.errEdit = ""
         },2500); 
			}else{
        //axios.put('http://192.168.0.15/~user15/BOOK_SHOP/client/api/auth/', 
        axios.put('http://localhost:88/BOOK_SHOP/client/api/auth/', 
        {
          edit: true,
          name: this.client.name,
          surname: this.client.surname,
          login: this.client.login,
          password: this.client.password,
          email: this.client.email,
          phone: this.client.phone,
          discount: this.client.discount,
          disable: this.client.disable,
          id: this.client.id
        }, this.config)
        .then(function (response) {
           if(response.data.data == '1'){
              self.isEdit = "record was updeted."
              setTimeout(function () {
                self.isEdit = ""
              },2500);
              self.$emit('updateClients')
              self.$emit('setSelect', 'client', self.client.id)  
           }
        })
        .catch(function (error) {
            self.errEdit = "somthing wrong, no update was made"
            setTimeout(function () {
              self.errEdit = ""
            },2500);
        });
        
      }
      }
      
   },

  
    check_phone(){
      var re = /^[\d]{10}$/;
      if (isNaN(this.client.phone) || re.test(this.client.phone) != true) {
        this.errEdit = "wrong phone format"
        return false
      }
      else {
        this.errEdit = ""
        return true
      }
	  },

    check_email() {
      var re = /^[\.\-_A-Za-z0-9]+?@[\.\-A-Za-z0-9]+?(\.)[A-Za-z0-9]{2,3}$/
      if (re.test(this.client.email) != true) {
        this.errEdit = "wrong email format"
        return false
      }
      else {
        this.errEdit = ""
        return true
      }
    },

    check_login(){
      var re = /^[\-_A-Za-z0-9]+$/
      if (re.test(this.client.login) !== true){
        this.errEdit = 'login contains invalid characters'
        return false
      }
      else if (this.client.login.length < 6){
        this.errEdit ='login is too short'
        return false
      }else {
        this.errEdit = ""
        return true
      }     
    },

    check_name(){
      var re1 = /^[A-Za-z]+$/
      if (re1.test(this.client.name) !== true){
          this.err_reg = 'name contains invalid characters'
          return false
      }else if(re1.test(this.client.surname) !== true){
        this.errEdit = 'surname contains invalid characters'
        return false
      }else {
        this.errEdit = ""
        return true
      }
    },

  },
  computed:{
    client_id: function(){
      this.client_show = true
      var id = this.$route.params.client_id
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/auth/'+ this.$route.params.client_id, this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/auth/'+ this.$route.params.client_id, this.config)
            .then(function (response) {
              console.log(response.data.data)
              self.client = response.data.data
              self.client.discount = parseFloat(self.client.discount)
              self.client.disable = parseInt(self.client.disable)
              self.client.password = ""
              if( self.client.length == 0){
                self.errEdit = "Information about this client is absent"
                self.client_show = false
              }
            })
            .catch(function (error) {
              self.errEdit = "Information about this client is absent"
              self.client_show = false
          }); 
      return id;
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
/*--error--*/
.err_info, .add_info{
  margin-top: 10px;
  font-weight: bold;
  font-size: 17px;
}

.err_info{
  color: #F00;
}

</style>
