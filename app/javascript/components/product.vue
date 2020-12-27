<template>
  <section>

    <b-button type="is-primary" @click="createItem">Crear Producto</b-button>
    <b-table
        :data="data"
        :paginated="isPaginated"
        :per-page="perPage"
        :current-page.sync="currentPage"
        :pagination-simple="isPaginationSimple"
        :pagination-position="paginationPosition"
        :default-sort-direction="defaultSortDirection"
        :pagination-rounded="isPaginationRounded"
        :sort-icon="sortIcon"
        :sort-icon-size="sortIconSize"
        default-sort="editItem.nombre"
        aria-next-label="Next page"
        aria-previous-label="Previous page"
        aria-page-label="Page"
        aria-current-label="Current page">

      <b-table-column field="id" label="ID" width="40" sortable numeric v-slot="props">
        {{ props.row.id }}
      </b-table-column>

      <b-table-column field="nombre" label="Nombre" sortable v-slot="props">
        {{ props.row.nombre }}
      </b-table-column>

      <b-table-column field="precio" label="Precio" sortable v-slot="props">
        {{ props.row.precio }}
      </b-table-column>

      <b-table-column field="cantidad" label="Cantidad" sortable v-slot="props">
        {{ props.row.cantidad }}
      </b-table-column>

      <b-table-column field="stock" label="Stock" sortable v-slot="props">
        {{ props.row.stock }}
      </b-table-column>

      <b-table-column field="description" label="Descripción" sortable v-slot="props">
        {{ props.row.description }}
      </b-table-column>

      <b-table-column label="" v-slot="props">

        <a @click="editItem(props.row)">
          <b-icon
              icon="edit"
              size="is-medium"
              type="is-primary"
          ></b-icon>
        </a>

        <a @click="deleteItem(props.row)">
          <b-icon
              icon="trash"
              size="is-medium"
              type="is-primary"
          ></b-icon>
        </a>

      </b-table-column>

      <b-table-column v-slot:no-data>
        <b-button type="is-primary" @click="initialize">Reset</b-button>
      </b-table-column>

    </b-table>

    <b-modal
        v-model="isComponentModalActive"
        has-modal-card
        trap-focus
        :destroy-on-hide="false"
        aria-role="dialog"
        aria-modal>
      <form action="">
        <input name="authenticity_token" type="hidden" v-bind:value="token">
        <div class="modal-card" style="width: auto">
          <header class="modal-card-head">
            <p class="modal-card-title">{{ formTitle }}</p>
            <button
                type="button"
                class="delete"
                @click="close"/>
          </header>
          <section class="modal-card-body">
            <b-field label="Nombre">
              <b-input v-model="editedItem.nombre"></b-input>
            </b-field>
            <b-field label="Precio">
              <b-numberinput v-model="editedItem.precio"></b-numberinput>
            </b-field>
            <b-field label="Cantidad">
              <b-numberinput v-model="editedItem.cantidad"></b-numberinput>
            </b-field>
            <b-field label="Stock">
              <b-numberinput v-model="editedItem.stock"></b-numberinput>
            </b-field>
            <b-field label="Descripción">
              <b-input maxlength="200" type="textarea" v-model="editedItem.description"></b-input>
            </b-field>
          </section>
          <footer class="modal-card-foot">
            <button class="button" type="button" @click="close">Close</button>
            <button class="button is-primary" @click="save(editedItem)">Guardar</button>
          </footer>
        </div>
      </form>
    </b-modal>
  </section>
</template>

<script>
import axios from "axios"

const data = []

export default {
  props: ['token'],
  data() {
    return {
      data: data,
      isPaginated: true,
      isPaginationSimple: false,
      isPaginationRounded: false,
      paginationPosition: 'bottom',
      defaultSortDirection: 'asc',
      sortIcon: 'arrow-up',
      sortIconSize: '',
      currentPage: 1,
      perPage: 10,
      isComponentModalActive: false,
      editedIndex: -1,
      editedItem: {
        nombre: "",
        precio: 0.0,
        cantidad: 0,
        stock: 0,
        description: ""
      },
      defaultItem: {
        nombre: "",
        precio: 0.0,
        cantidad: 0,
        stock: 0,
        description: ""
      }
    }
  },
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "Nuevo Producto" : "Edición de Producto";
    }
  },
  created() {
    this.initialize();
  },
  methods: {
    initialize() {
      return axios
          .get("http://localhost:3000/api/products.json")
          .then(response => {
            this.data = response.data;
          })
          .catch(e => {
            console.log(e);
          });
    },
    close() {
      this.editedItem = Object.assign({}, this.defaultItem);
      this.editedIndex = -1;
      this.isComponentModalActive = false;
    },
    success(msg) {
      this.$buefy.toast.open({
        message: msg,
        type: 'is-success',
        duration: 3000
      })
    },
    getProduct(item) {
      axios.get('https://localhost:3000/api/products/' + item.id)
          .then(response => {
            this.data = response.data;
          })
          .catch(error => {
            console.log(error);
          })
    },
    editItem(item) {
      this.editedIndex = item.id;
      this.editedItem = Object.assign({}, item);
      this.isComponentModalActive = true;
    },
    createItem() {
      this.editedItem = Object.assign({}, this.defaultItem);
      this.isComponentModalActive = true;
    },

    save(item) {
      if (this.editedIndex > -1) {
        axios
            .put('http://localhost:3000/api/products/' + item.id+'.json', {
              authenticity_token: this.token,
              product: this.editedItem
            })
            .then(response => {
              this.initialize();
              this.success(response.message);
            })
            .catch(error => {
              console.log(error);
            });
      } else {
        axios
            .post('http://localhost:3000/api/products.json', {
              authenticity_token: this.token,
              product: this.editedItem
            })
            .then(response => {
              this.initialize();
              this.success('Producto creado');
            })
            .catch(error => {
              console.log(error);
            });
      }
      this.close();
    },
    deleteItem(item) {
      const index = this.data.indexOf(item);
      if (confirm("Are you sure you want to delete this item?")) {
        axios
            .delete('http://localhost:3000/api/products/' + item.id)
            .then(response => {
              this.initialize();
              this.success(response.data.json);
            })
            .catch(error => {
              console.log(error);
            });

      }

    }
  }

}
</script>