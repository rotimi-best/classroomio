<script>
  import CloseIcon from 'carbon-icons-svelte/lib/Close.svelte';
  import IconButton from '$lib/components/IconButton/index.svelte';

  export let onClick = () => {};
  export let contained = false;
  export let color = 'text-primary-700 bg-primary-200 dark:bg-neutral-500';
  export let size = 'small';
</script>

<IconButton {onClick} {color} {contained} {size}>
  {#if size === 'large'}
    <CloseIcon size={24} class="carbon-icon dark:text-black" title="Delete" />
  {:else}
    <CloseIcon size={20} class="carbon-icon dark:text-black" title="Delete" />
  {/if}
</IconButton>
<!-- color="text-primary-700 bg-primary-200 dark:bg-gray-200 dark:text-black" -->
