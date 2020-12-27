<template>
  <div id="Buttonc">
    <b-button :type="'is-'+color" v-for="(color, i) in colores" :key="i">
      {{ color }}
    </b-button>
  </div>
</template>

<script>
export default {
  name: "ButtonComponent",
  data: function(){
      return {}
  },
  props: ['colores'],
};
</script>