<template>
<div class="addauthor">
  <div class="err_info">{{errEdit}}</div>
  <div class="add_info">{{isEdit}}</div>
  <div class="add_info">{{isDelRec}}</div>
  <div class="add" v-if="author_show">
    <div class="lbl_add">Author(id:{{author_id}}) edit form</div>
      <div class="form-group">
        <label for="inputName">Name</label>
        <input type="text" class="form-control" id="inputName" placeholder="Enter name" v-model="author.name">
      </div>
      <div class="form-group">
        <label for="inputSname">Surname</label>
        <input type="text" class="form-control" id="inputSname" placeholder="Enter surname" v-model="author.surname">
      </div>
      <button  class="btn btn-primary"  @click="edit_author">Edit author</button>
      <button  class="btn btn-del" @click="delete_author">Delete author</button>
      <button class="btn btn-cans"@click="cancel">Cancel</button> 
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'addAuthor',
  data () {
    return {
      errEdit: "",
      isEdit: "",
      author: {},
      author_show: true,
      isDelRec: ""
    }
  },
  methods:{
    edit_author(){
      var self = this
      if(this.author.name != "" || this.author.surname != ""){
        //axios.put('http://192.168.0.15/~user15/BOOK_SHOP/client/api/author/', 
        axios.put('http://localhost:88/BOOK_SHOP/client/api/author/', 
        {
          name: this.author.name,
          surname: this.author.surname,
          id: this.author.id
        }, this.config)
        .then(function (response) {
           if(response.data.data == '1'){
              self.isEdit = "record was updeted."
              setTimeout(function () {
                self.isEdit = ""
              },2500);
              self.$emit('updateAuthors')
              self.$emit('setSelect', 'author', self.author.id)  
           }
        })
        .catch(function (error) {
            self.errEdit = "somthing wrong, no update was made"
            setTimeout(function () {
              self.errEdit = ""
            },2500);
        });
      }else{
        this.errEdit = "fill the field"
        var self = this
        setTimeout(function () {
            self.errEdit = ""
        },2500);   
      }
    },

    delete_author(){
      var self=this
      axios.delete('http://localhost:88/BOOK_SHOP/client/api/author/'+this.author_id, this.config)
      //axios.delete('http://192.168.0.15/~user15/BOOK_SHOP/client/api/author/'+this.author_id, this.config)
        .then(function (response) {
          console.log(response.data.data)
          if(response.data.data=="1"){
            self.isDelRec = "Record  deleted."
            self.$emit('updateAuthors')
            self.$emit('clearSelect')
            setTimeout(function () {
              self.isDelRec = ""
              self.$router.push({path: '/admin'})
            },2500); 
          }else{
            self.errEdit = "Record doesn't deleted. there may be books that link to this entry"
            setTimeout(function () {
                self.errEdit = ""
            },2500); 
          }
        })
        .catch(function (error) {
          self.errEdit = "Record doesn't deleted. there may be books that link to this entry"
          setTimeout(function () {
              self.errEdit = ""
            },2500); 
        });
    },

    cancel(){
     this.$emit('clearSelect')
     this.$router.push({path: '/admin'})
   }
  },
   computed:{
    author_id: function(){
      this.author_show = true
      var id = this.$route.params.author_id
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/author/'+ this.$route.params.author_id, this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/author/'+  this.$route.params.id, this.config)
            .then(function (response) {
              //console.log(response.data)
              self.author = response.data.data
               //console.log(temp)
              if( self.author.length == 0){
                self.errEdit = "Information about this author is absent"
                self.author_show = false
              }
            })
            .catch(function (error) {
              self.errEdit = "Information about this author is absent"
              self.author_show = false

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
  margin-top: 20px;
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
