<template>
<div class="editganre">
  <div class="err_info">{{errEdit}}</div>
  <div class="add_info">{{isEdit}}</div>
  <div class="add_info">{{isDelRec}}</div>
  <div class="add" v-if="ganre_show">
        <div class="lbl_add">Ganre(id:{{ganre_id}}) edit form:</div>
          <div class="form-group">
            <label for="inputGName">Name</label>
            <input type="text" class="form-control" id="inputGName" placeholder="Enter name" v-model="ganre.name">
          </div>
          <button  class="btn btn-primary" @click="edit_ganre">Edit ganre</button>
          <button  class="btn btn-del" @click="delete_ganre">Delete ganre</button>
          <button class="btn btn-cans"@click="cancel">Cancel</button> 
        </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'editGanre',
  data () {
    return {
      ganre: {},
      errEdit: "",
      isEdit: "",
      ganre_show: true,
      isDelRec: "",

    }
  },
  created(){
  },
  methods:{
    edit_ganre(){
      var self = this
      if(this.ganre.name != ""){
        //axios.put('http://192.168.0.15/~user15/BOOK_SHOP/client/api/ganre/', 
        axios.put('http://localhost:88/BOOK_SHOP/client/api/ganre/', 
        {
          name: this.ganre.name,
          id: this.ganre.id
        }, this.config)
        .then(function (response) {
           if(response.data.data == '1'){
              self.isEdit = "record was updeted."
              setTimeout(function () {
                self.isEdit = ""
              },2500);
              self.$emit('updateGanres')
              self.$emit('setSelect', 'ganre', self.ganre.id)  
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

   delete_ganre(){
    var self=this
    axios.delete('http://localhost:88/BOOK_SHOP/client/api/ganre/'+this.ganre_id, this.config)
    //axios.delete('http://192.168.0.15/~user15/BOOK_SHOP/client/api/ganre/'+this.ganre_id, this.config)
      .then(function (response) {
        console.log(response.data.data)
        if(response.data.data=="1"){
          self.isDelRec = "Record  deleted."
          self.$emit('updateGanres')
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
    ganre_id: function(){
      this.ganre_show = true
      var id = this.$route.params.id
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/ganre/'+ this.$route.params.id, this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/ganre/'+ this.$route.params.id, this.config)
            .then(function (response) {
              self.ganre = response.data.data
              if( self.ganre.length == 0){
                self.errEdit = "Information about this gare is absent"
                self.ganre_show = false
              }
            })
            .catch(function (error) {
              self.errEdit = "Information about this ganre is absent"
              self.ganre_show = false
              
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
