<script>
  import { onDestroy } from 'svelte';
  import { goto } from '$app/navigation';
  import AddAltIcon from 'carbon-icons-svelte/lib/AddAlt.svelte';
  import ViewIcon from 'carbon-icons-svelte/lib/View.svelte';
  import ViewFilledIcon from 'carbon-icons-svelte/lib/ViewFilled.svelte';
  import {
    handleAddQuestion,
    questionnaire,
    validateQuestionnaire,
    reset,
    questionnaireOrder
  } from '../store/exercise';
  import {
    ContentSwitcher,
    Switch,
    Breadcrumb,
    BreadcrumbItem,
    OverflowMenu,
    OverflowMenuItem
  } from 'carbon-components-svelte';
  import PrimaryButton from '$lib/components/PrimaryButton/index.svelte';
  import PageBody from '$lib/components/PageBody/index.svelte';
  import IconButton from '$lib/components/IconButton/index.svelte';
  import RoleBasedSecurity from '$lib/components/RoleBasedSecurity/index.svelte';
  import ViewMode from './ViewMode.svelte';
  import EditMode from './EditMode.svelte';
  import { VARIANTS } from '$lib/components/PrimaryButton/constants';
  import { upsertExercise } from '$lib/utils/services/courses';
  import UpdateDescription from './UpdateDescription.svelte';
  import { snackbar } from '$lib/components/Snackbar/store';
  import Analytics from './Submissions/index.svelte';

  export let exerciseId = '';
  export let path = '';
  export let goBack = () => {};
  export let isStudent = true;

  let preview = false;
  let shouldDeleteExercise = false;
  let isSaving = false;
  let selectedIndex = 0;

  async function handleSave() {
    if (isStudent) return;

    const errors = validateQuestionnaire($questionnaire.questions);
    if (Object.values(errors).length > 0) {
      return;
    }
    isSaving = true;

    reset();
    try {
      const updatedQuestions = await upsertExercise($questionnaire, exerciseId);

      questionnaire.update((q) => ({
        ...q,
        is_title_dirty: false,
        is_description_dirty: false,
        // @ts-ignore
        questions: updatedQuestions
      }));
      snackbar.success('Saved Successfully');

      // Redirect to exercises page
      goto(path);
    } catch (error) {
      console.error(error);
      snackbar.error();
    }
    isSaving = false;
  }

  onDestroy(() => {
    reset();
  });

  $: $questionnaire?.questions?.length < 1 && handleAddQuestion();
  console.log('question', $questionnaire.questions);
</script>

<PageBody bind:isPageNavHidden={isStudent} padding="px-4 overflow-x-hidden">
  <div class="bg-gray-100 dark:bg-neutral-800 top-0 z-10 sticky p-2 mb-3">
    <Breadcrumb noTrailingSlash class="mb-5">
      <BreadcrumbItem href={path}>All Exercises</BreadcrumbItem>
      <BreadcrumbItem href={`${path}${exerciseId}`} isCurrentPage>
        {$questionnaire.title}
      </BreadcrumbItem>
    </Breadcrumb>

    <RoleBasedSecurity allowedRoles={[1, 2]}>
      <ContentSwitcher bind:selectedIndex class="mb-2">
        <Switch text="Questions ({$questionnaire.questions.length})" />
        <Switch text="Submissions ({$questionnaire.totalSubmissions})" />
      </ContentSwitcher>

      {#if selectedIndex === 0}
        <div class="flex items-center justify-end right-0 w-full">
          <div class="flex items-center">
            <PrimaryButton
              className="mr-2"
              variant={VARIANTS.CONTAINED}
              label="Save"
              onClick={handleSave}
              isLoading={isSaving}
            />
            <IconButton
              onClick={() => (preview = !preview)}
              contained={preview}
              toolTipProps={{
                title: 'Preview',
                direction: 'bottom',
                hotkeys: []
              }}
            >
              {#if preview}
                <ViewFilledIcon size={24} class="carbon-icon dark:text-white" />
              {:else}
                <ViewIcon size={24} class="carbon-icon dark:text-white" />
              {/if}
            </IconButton>
            <IconButton onClick={() => handleAddQuestion()} size="small">
              <AddAltIcon size={24} class="carbon-icon dark:text-white" />
            </IconButton>
            <OverflowMenu flipped>
              <OverflowMenuItem
                text="Reorder Questions"
                on:click={() => ($questionnaireOrder.open = true)}
              />
              <OverflowMenuItem
                danger
                text="Delete Exercise"
                on:click={() => (shouldDeleteExercise = true)}
              />
            </OverflowMenu>
          </div>
        </div>
      {/if}
    </RoleBasedSecurity>
  </div>

  {#if selectedIndex === 0}
    <RoleBasedSecurity allowedRoles={[1, 2]}>
      <UpdateDescription {preview} />
    </RoleBasedSecurity>
    {#if !isStudent && !preview}
      <EditMode bind:shouldDeleteExercise {exerciseId} {goBack} />
    {:else}
      <ViewMode {preview} {exerciseId} />
    {/if}
  {:else if selectedIndex === 1}
    <Analytics bind:exerciseId />
  {/if}
</PageBody>
