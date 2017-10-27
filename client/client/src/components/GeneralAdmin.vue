<template>
  <div class="general container">
    <div class="row">
      <div class="col-sm-12 col-md-3">
      <!--author-->  
      <div class="section">
        <router-link class="btn  btn-info"  :to="'/admin/addAuthor'">
          new Author
        </router-link>

        <div class="form-group">
          <label>Edit or Delete</label>
          <select v-model="author" class="form-control"  @change="changeSelectAuthor()">
            <option value="">select author</option>
            <option v-for="author in authors" :value="author.id" :key="author.id">
                  {{author.surname}} {{author.name}}
            </option>
          </select>
        </div>
      </div>
      <!--endauthor--> 
      <!--ganere-->
      <div class="section">
        <router-link class="btn  btn-info"  :to="'/admin/addGanre'">
          new Ganre
        </router-link>
        <div class="form-group">
          <label>Edit or Delete</label>
          <select v-model="ganre" class="form-control"  @change="changeSelectGanre()">
            <option value="">select ganre</option>
            <option v-for="ganre in ganres" :value="ganre.id" :key="ganre.id">
              {{ganre.name}}
            </option>
          </select>
        </div>
      </div>
      <!--endganre-->
      <!--book-->
      <div class="section">
        <router-link class="btn  btn-info"  :to="'/admin/addBook'">
          new Book
        </router-link>

        <div class="form-group">
          <label>Edit or Delete</label>
          <select v-model="book" class="form-control"  @change="changeSelectBook()">
            <option value="">select book</option>
            <option v-for="book in books" :value="book.id" :key="book.id">
              {{book.name}}
            </option>
          </select>
        </div>
      </div>
      <!--endbook-->
      <!--client-->
      <div class="section">
        <router-link class="btn  btn-info"  :to="'/admin/addClient'">
          new Client
        </router-link>

        <div class="form-group">
          <label>Edit</label>
          <select v-model="client" class="form-control"  @change="changeSelectClient()">
            <option value="">select client</option>
            <option v-for="client in clients" :value="client.id" :key="client.id">
              {{client.surname}} {{client.name}}
            </option>
          </select>
        </div>
      </div>
      <!--endbook-->

       <!--orders-->
      <div class="section">
        <router-link class="btn  btn-info"  :to="'/admin/showOrders'">
          show orders
        </router-link>
      </div>
      <!--endbook-->
      </div>
      <div class="col-sm-12 col-md-9">
           <router-view 
           @updateGanres="getGanres"
           @updateAuthors="getAuthors"
           @updateBooks="getBooks"
           @updateClients="getClients"
           @clearSelect="clearSelect"
           @setSelect="setSelect"
           ></router-view>
       </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'general_admin',
  data () {
    return {
       config: {
          headers: {'Content-Type': 'application/x-www-form-urlencoded'}
      },
      err_author: "",
      name: "",
      surname: "",
      is_author: false,
      author: "",
      authors: [],

      err_ganre: "",
      ganre_name: "",
      is_ganre: false,
      ganres: [],
      ganre: "",


      err_book: "",
      is_book: false,
      books: [],
      book: "",

     clients: [],
     client: ""

    }
  },
  created(){
      this.getGanres()
      this.getAuthors()
      this.getBooks()
      this.getClients()
  },
  methods:{
    getGanres(){
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/ganre/', this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/ganre/', this.config)
            .then(function (response) {
              //console.log(response.data);
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
              //console.log(response.data);
                self.authors = response.data.data
      })
      .catch(function (error) {
        console.log(error);
      });
    },

    getBooks(){
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/book/', this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/book/', this.config)
            .then(function (response) {
              //console.log(response.data);
                self.books = response.data.data
      })
      .catch(function (error) {
        console.log(error);
      });
    },

    getClients(){
      var self = this
      axios.get('http://localhost:88/BOOK_SHOP/client/api/auth/', this.config)
      //axios.get('http://192.168.0.15/~user15/BOOK_SHOP/client/api/auth/', this.config)
            .then(function (response) {
              //console.log(response.data);
                self.clients = response.data.data
      })
      .catch(function (error) {
        console.log(error);
      });
    },

    changeSelectAuthor(){
      //alert(this.author)
      this.$router.push({path: '/admin/editAuthor/'+ this.author})
      this.ganre = ""
      this.book = ""
      this.client = ""
    },

    changeSelectGanre(){
      this.$router.push({path: '/admin/editGanre/'+ this.ganre})
      this.author = ""
      this.book = ""
      this.client = ""
    },
  
    changeSelectBook(){
      this.$router.push({path: '/admin/editBook/'+ this.book})
      this.ganre = ""
      this.author = ""
      this.client = ""
    },

    changeSelectClient(){
      this.$router.push({path: '/admin/editClient/'+ this.client})
      this.ganre = ""
      this.author = ""
      this.book = ""
    },

    clearSelect(){
      this.ganre = this.book = this.author = this.client = ""
    },

    setSelect(select,id){
      switch(select){
        case 'ganre':
          this.ganre = id
          break
        case 'book':
          this.book = id
          break  
        case 'author':
          this.author = id
          break
        case 'client':
          this.client = id
          break  
       }
       
     }

  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.general{
  text-align: left;
  color: #FFF;
  margin-top: 20px;
}

.section{
  margin-bottom: 50px;
}

.btn-cans{
  background-color: #66CABF;
}

.btn-del{
  background-color: #2C3E50;
}
</style>
