<script lang="ts">
  export let label = '';
  export let placeholder = '';
  export let value: string | Date = '';
  export let className = '';
  export let onInput = () => {};
  export let isRequired: boolean = false;
</script>

<label class="block {className}">
  <span class="text-gray-700 dark:text-white"
    >{label}
    {#if isRequired}
      <span class="text-red-700">*</span>
    {/if}
  </span>
  <input
    bind:value
    on:input={onInput}
    {placeholder}
    type="datetime-local"
    class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 dark:bg-neutral-800 dark:text-white"
  />
</label>
