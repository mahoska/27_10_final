<template>
<div class="editbook">
  <div class="err_info">{{errEdit}}</div>
  <div class="add_info">{{isEdit}}</div>
  <div class="add_info">{{isDelRec}}</div>
  <div class="add" v-if="book_show">
    <div class="lbl_add">Book(id:{{book_id}}) add form</div>
      <div class="form-group">
        <label for="inputName">Name</label>
        <input type="text" class="form-control" id="inputName" placeholder="Enter name" v-model="book.name">
      </div>

      <div class="form-group">
        <label for="inputDescr">Description</label>
        <textarea class="form-control" id="inputDescr" placeholder="Enter description" v-model="book.description" rows="5"></textarea>
      </div>

      <div class="row">
        <div  class="col-sm-10 col-md-5">
          <div class="form-group">
            <label for="inputPrice">Price</label>
            <input type="number" min='0' step='0.1' class="form-control" id="inputPrice" placeholder="Enter price" v-model="book.price">
          </div>
        </div>
        <div  class="col-sm-2 col-md-2">
          <button  class="btn btn-primary" @click="edit_book" style="margin-top:25px">Edit book</button>
        </div>
        <div  class="col-sm-10 col-md-5">
          <div class="form-group">
            <label for="inputDiscount">Discount</label>
            <input type="number" min='0' step='0.1' class="form-control" id="inputDiscount" placeholder="Enter discount" v-model="book.discount">
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
          <button  class="btn btn-primary" @click="edit_ganres">Edit ganres</button>
          <button  class="btn btn-del" @click="delete_ganres_book">Delete ganres</button>
        </div>
        <div  class="col-sm-2 col-md-2"></div>
        <div  class="col-sm-10 col-md-5">
          <div class="form-group">
            <label for="inputAuthor">Author(s)</label>
            <select multiple class="form-control"  v-model="book_authors">
              <option v-for="author in authors" :key="author.id" :value="author.id">{{author.name}} {{author.surname}}</option>
            </select>
          </div>
          <button  class="btn btn-primary" @click="edit_authors">Edit authors</button>
           <button  class="btn btn-del" @click="delete_authors_book">Delete authors</button>
        </div>
      </div>
      
      <div class="row">
        <div  class="col-sm-12 col-md-12" style="text-align:right; margin-top:20px;">
          <button  class="btn btn-del" @click="delete_book">Delete book</button>
          <button class="btn btn-cans"@click="cancel">Cancel</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'editBook',
  data () {
    return {
      book: {},
      errEdit: "",
      isEdit: "",
      book_show: true,
      book_authors: [],
      book_ganres: [],
      ganres: [],
      authors: [],
      isDelRec: ""
    }
  },
  created(){
    this. getGanres()
    this. getAuthors()
  },
  methods:{
    edit_ganres(){
       this.errEdit = ""
      if(this.book_ganres.length!=0){
       var self = this
         //axios.put('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book_ganre/', 
        axios.put('http://localhost:88/BOOK_SHOP/client/api/book_ganre/', 
        {
           book_ganres: this.book_ganres,
           id: this.book.id
        }, this.config)
        .then(function (response) {
           if(response.data.data == '1'){
              self.isEdit = "record was updeted."
              setTimeout(function () {
                self.isEdit = ""
              },2500);
           }
        })
        .catch(function (error) {
            self.errEdit = "somthing wrong, no update was made"
            setTimeout(function () {
              self.errEdit = ""
            },2500);
        });
      }else{
        this.errEdit = "no genre selected"
        var self = this
        setTimeout(function () {
            self.errEdit = ""
        },2500); 
      }
    },

    edit_authors(){
      this.errEdit = ""
      if(this.book_authors.length!=0){
      var self = this
         //axios.put('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book_author/', 
        axios.put('http://localhost:88/BOOK_SHOP/client/api/book_author/', 
        {
            book_authors: this.book_authors,
            id: this.book.id
        }, this.config)
        .then(function (response) {
          var kolUpdRec = parseInt(response.data.data)
           if(kolUpdRec >0 ){
              self.isEdit = "authors-record was updeted."
              setTimeout(function () {
                self.isEdit = ""
              },2500);
           }
        })
        .catch(function (error) {
            self.errEdit = "somthing wrong, no update was made"
            setTimeout(function () {
              self.errEdit = ""
            },2500);
        });
         }else{
        this.errEdit = "no author selected"
        setTimeout(function () {
            this.errEdit = ""
        },2500); 
      }
    },

    edit_book(){
       this.errEdit = ""
      var self = this
      if(this.book.name != ""){
         //axios.put('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book/', 
        axios.put('http://localhost:88/BOOK_SHOP/client/api/book/', 
        {
          name: this.book.name,
          description: this.book.description,
          price: this.book.price,
          discount: this.book.discount,
          id: this.book.id
        }, this.config)
        .then(function (response) {
           if(response.data.data == '1'){
              self.isEdit = "book-record was updeted."
              setTimeout(function () {
                self.isEdit = ""
              },2500);
              self.$emit('updateBooks')
              self.$emit('setSelect', 'book', self.book.id)  
           }
        })
        .catch(function (error) {
            self.errEdit = "somthing wrong, no update was made"
            setTimeout(function () {
              self.errEdit = ""
            },2500);
        });
      }else{
        this.errEdit = "fill the name field"
        setTimeout(function () {
            this.errEdit = ""
        },2500);   
      }
   },

    getGanres(){
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/ganre/', this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/ganre/', this.config)
            .then(function (response) {
              self.ganres = response.data.data
      })
      .catch(function (error) {
        console.log(error);
      });
    },

    getAuthors(){
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/author/', this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/author/', this.config)
            .then(function (response) {
                self.authors = response.data.data
      })
      .catch(function (error) {
        console.log(error);
      });
    },

    cancel(){
     this.$emit('clearSelect')
     this.$router.push({path: '/admin'})
   },

  delete_book(){
    var self=this
   if(this.book_authors.length==0 && this.book_ganres.length==0){
      axios.delete('http://localhost:88/BOOK_SHOP/client/api/book/'+this.book_id, this.config)
      //axios.delete('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book/'+this.book_id, this.config)
        .then(function (response) {
          console.log(response.data.data)
          if(response.data.data=="1"){
            self.isDelRec = "Record  deleted."
            self.$emit('updateBooks')
            self.$emit('clearSelect')
            setTimeout(function () {
              self.isDelRec = ""
              self.$router.push({path: '/admin'})
            },2500); 
          }else{
            self.errEdit = "Record doesn't deleted. This entry is associated with other records"
            setTimeout(function () {
                self.errEdit = ""
            },2500); 
          }
        })
        .catch(function (error) {
          self.errEdit = "Record doesn't deleted. This entry is associated with other records"
          setTimeout(function () {
              self.errEdit = ""
            },2500); 
      });
      }else{
        this.errEdit = "Record doesn't deleted. Perhaps this book has connecting records in other tables."+
         "You must delete all entries about authors and genres of this book."
         var self = this 
          setTimeout(function () {
              self.errEdit = ""
            },2500); 
      }
    },

  delete_authors_book(){
    var self=this
    if(this.book_authors.length!=0){
      axios.delete('http://localhost:88/BOOK_SHOP/client/api/book_author/'+this.book_id, this.config)
      //axios.delete('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book_author/'+this.book_id, this.config)
        .then(function (response) {
          console.log(response.data.data)
          if(response.data.data=="1"){
            self.isDelRec = "Record(s)  deleted."
            self.book_authors = []
            setTimeout(function () {
              self.isDelRec = ""
            },2500); 
          }else{
            self.errEdit = "Record doesn't deleted."
            setTimeout(function () {
                self.errEdit = ""
            },2500); 
          }
        })
        .catch(function (error) {
          self.errEdit = "Record doesn't deleted."
          setTimeout(function () {
              self.errEdit = ""
            },2500); 
      });
    }
  },

delete_ganres_book(){
    var self=this
    if(this.book_ganres.length!=0){
      axios.delete('http://localhost:88/BOOK_SHOP/client/api/book_ganre/'+this.book_id, this.config)
      //axios.delete('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book_ganre/'+this.book_id, this.config)
        .then(function (response) {
          console.log(response.data.data)
          if(response.data.data=="1"){
            self.isDelRec = "Record(s)  deleted."
            self.book_ganres = []
            setTimeout(function () {
              self.isDelRec = ""
            },2500); 
          }else{
            self.errEdit = "Record doesn't deleted."
            setTimeout(function () {
                self.errEdit = ""
            },2500); 
          }
        })
        .catch(function (error) {
          self.errEdit = "Record doesn't deleted."
          setTimeout(function () {
              self.errEdit = ""
            },2500); 
      });
    }
  },

  },
  
  computed:{
    book_id: function(){
      this.book_show = true
      var id = this.$route.params.book_id
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/book/'+ this.$route.params.book_id, this.config)
    //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book/'+ this.$route.params.book_id, this.config)
            .then(function (response) {
              self.book = response.data.data
              if( self.book.length == 0){
                self.errEdit = "Information about this book is absent"
                self.book_show = false
              }

              if(self.book.ganres_id!=null){
               self.book_ganres_id = self.book.ganres_id.split(',')
               self.book_ganres = self.book_ganres_id.map(function(el) {
                return parseInt(el);
              });
              }else self.book_ganres = []

              if(self.book.authors_id!=null){
                self.book_authors_id = self.book.authors_id.split(',')
               self.book_authors = self.book_authors_id.map(function(el) {
                return parseInt(el);
              });
              }else self.book_authors = []
              //console.log(self.book_ganres)
              //console.log(self.book_authors)
              //console.log(self.book)
            })
            .catch(function (error) {
              self.errEdit = "Information about this ganre is absent"
              self.book_show = false

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

.btn-del{
  background-color: #2C3E50;
}
</style>
