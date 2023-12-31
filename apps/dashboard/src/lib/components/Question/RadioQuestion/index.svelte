<script lang="ts">
  import CodeSnippet from '$lib/components/CodeSnippet/index.svelte';
  import PrimaryButton from '$lib/components/PrimaryButton/index.svelte';
  import { VARIANTS } from '$lib/components/PrimaryButton/constants';
  import RadioItem from '$lib/components/Form/RadioItem.svelte';
  import HtmlRender from '$lib/components/HTMLRender/HTMLRender.svelte';
  import Grade from '$lib/components/Question/Grade.svelte';

  export let title = '';
  export let index = 1;
  export let code = '';
  export let name = '';
  export let options = [];
  export let onSubmit = () => {};
  export let onPrevious = () => {};
  export let defaultValue = '';
  export let disablePreviousButton = false;
  export let disabled = false;
  export let isPreview = false;
  export let nextButtonProps = {};
  export let grade: number;
  export let gradeMax = 0;
  export let disableGrading = false;
  export let labelClassName = '';
  export let disableOptContainerMargin = false;

  function getRadioVal(form, name) {
    let val;
    const radios = form.elements[name];

    for (let i = 0, len = radios.length; i < len; i++) {
      if (radios[i].checked) {
        val = radios[i].value;
        break;
      }
    }
    return val;
  }

  function handleFormSubmit(event) {
    if (isPreview) return;
    const value = getRadioVal(event.target, name);
    onSubmit(name, [value], nextButtonProps.isActive);
    event.target.reset();
  }

  function handlePrevious(event) {
    event.preventDefault();
    onPrevious();
  }

  function getValidationClassName(option) {
    if (defaultValue.includes(option.value)) {
      if (option.is_correct) {
        return 'border-green-700';
      } else {
        return 'border-red-700';
      }
    }

    return '';
  }
</script>

<form on:submit|preventDefault={handleFormSubmit}>
  <div class="flex items-center justify-between">
    <HtmlRender className="mt-4">
      <svelte:fragment slot="content">
        <span class="dark:text-white flex items-center gap-1 {labelClassName}">
          <h3>{index}</h3>
          <h3>{title}</h3>
        </span>
      </svelte:fragment>
    </HtmlRender>
    <Grade {gradeMax} bind:grade {disableGrading} />
  </div>

  {#if code}
    <CodeSnippet {code} />
  {/if}

  <div class={!disableOptContainerMargin && 'ml-4'}>
    {#each options as option}
      <button
        class="cursor-pointer text-left my-2 border-2 border-gray-300 rounded-md hover:bg-gray-200 dark:hover:bg-neutral-800 w-full {getValidationClassName(
          option
        )}"
        type="button"
      >
        <RadioItem
          className="p-2"
          {name}
          value={option.value}
          checked={defaultValue.includes(option.value) && option.is_correct}
          label={option.label || option.value}
          {disabled}
        />
      </button>
    {/each}
  </div>

  {#if !isPreview}
    <div class="mt-3 flex items-center justify-between w-full">
      <PrimaryButton
        onClick={handlePrevious}
        label="Previous"
        isDisabled={disablePreviousButton}
        variant={VARIANTS.OUTLINED}
      />
      <PrimaryButton
        variant={nextButtonProps.isActive ? VARIANTS.CONTAINED : VARIANTS.OUTLINED}
        type="submit"
        label={nextButtonProps.label}
        {name}
      />
    </div>
  {/if}
</form>
