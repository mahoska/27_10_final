<template>
<div class="addbook">
  <div class="add">
  <div class="err_info">{{errAdd}}</div>
  <div class="add_info">{{isAdd}}</div>
    <div class="lbl_add">Book add form</div>
      <div class="form-group">
        <label for="inputName">Name*</label>
        <input type="text" class="form-control" id="inputName" placeholder="Enter name" v-model="name">
      </div>

      <div class="form-group">
        <label for="inputDescr">Description</label>
        <textarea class="form-control" id="inputDescr" placeholder="Enter description" v-model="description" rows="5"></textarea>
      </div>

      <div class="row">
        <div  class="col-sm-10 col-md-5">
          <div class="form-group">
            <label for="inputPrice">Price</label>
            <input type="number" min='0' step='0.1' class="form-control" id="inputPrice" placeholder="Enter price" v-model="price">
          </div>
        </div>
        <div  class="col-sm-2 col-md-2"></div>
        <div  class="col-sm-10 col-md-5">
          <div class="form-group">
            <label for="inputDiscount">Discount</label>
            <input type="number" min='0' step='0.1' class="form-control" id="inputDiscount" placeholder="Enter discount" v-model="discount">
          </div>
        </div>
      </div>    

      <div class="row">
        <div  class="col-sm-10 col-md-5">
          <div class="form-group">
            <label for="inputGanre">Ganre(s)</label>
            <select multiple class="form-control" v-model="book_ganres">
              <option v-for="ganre in ganres" :key="ganre.id" :value="ganre.id">{{ganre.name}}</option>
            </select>
          </div>
        </div>
        <div  class="col-sm-2 col-md-2"></div>
        <div  class="col-sm-10 col-md-5">
          <div class="form-group">
            <label for="inputAuthor">Author(s)</label>
            <select multiple class="form-control"  v-model="book_authors">
              <option v-for="author in authors" :key="author.id" :value="author.id">{{author.name}} {{author.surname}}</option>
            </select>
          </div>
        </div>
      </div>
      
      <button  class="btn btn-primary" @click="add_book">Add book</button>
      <input type="reset" class="btn btn-cans" value="Cancel" @click="clear">
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'addAuthor',
  data () {
    return {
      book: {},
      ganres: [],
      authors: [],
      book_ganres: [],
      book_authors: [],
      name: "",
      description: "",
      price: 0,
      discount: 0,
      isAdd: "",
      errAdd: ""

    }
  },
  created(){
    this.$emit('clearSelect') 
    var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/ganre/', this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/ganre/', this.config)
            .then(function (response) {
              self.ganres = response.data.data 
              //console.log(self.ganres)
      })
      .catch(function (error) {
        //console.log(error)
      });

      axios.get('http://localhost:88/BOOK_SHOP/client/api/author/', this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/author/', this.config)
            .then(function (response) {
              //console.log(response.data)
              self.authors = response.data.data 

      })
      .catch(function (error) {
        console.log(error)
      });
  },
  methods:{
    clear(){
     this.name = this.description = "" 
     this.price = this.discount = 0
     this.book_ganres = this.book_authors = []

     this.$router.push({path: '/admin'})   
    },

    add_book(){
      var self = this
      if(this.name != ""){
      var data = new FormData()
      data.append("name", this.name) 
      data.append("description", this.description) 
      data.append("price", this.price) 
      data.append("discount", this.discount) 
      data.append("book_ganres", this.book_ganres) 
      data.append("book_authors", this.book_authors)  
      //console.log( this.book_ganres)
        axios.post('http://localhost:88/BOOK_SHOP/client/api/book/', data, self.config)         
        //axios.post('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book/', data, self.config)
        .then(function (response) {
          console.log(response.data.data)
          if(response.data.err && response.data.err ==true){
              self.errAdd = response.data.data
              setTimeout(function () {
                self.errAdd = ""
              },2500);
            }else if(response.data.data.bookAdd == '1') {
              self.isAdd = "Record about book successfully added."+ 
              " Added "+response.data.data.ganreAdd+" ganre(s) of books"+
              " Added "+response.data.data.authorAdd+" authors(s)  of books"
              setTimeout(function () {
                self.isAdd = ""
              },3000);
              self.$emit('updateBooks') 
          } 
          self.name = "" 
          self.description = ""   
          self.price = 0
          self.discount = 0 
          self.book_ganres = []
          self.book_authors = []   
          })
          .catch(function (error) {
            self.errAdd = "error adding"
            setTimeout(function () {
               self.errAdd = ""
            },2500);   
          });
      }else{
        this.errAdd = "error adding"
        var self = this
        setTimeout(function () {
            self.errAdd = "fill the fields"
        },2500);   
      }
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
/*--error--*/
.err_info, .add_info{
  margin-top: 20px;
  font-weight: bold;
  font-size: 17px;
}

.err_info{
  color: #F00;
}
</style>
