<script>
  import { onMount } from 'svelte';
  import Modal from '$lib/components/Modal/index.svelte';
  import Select from '$lib/components/Form/Select.svelte';
  import PrimaryButton from '$lib/components/PrimaryButton/index.svelte';
  import { VARIANTS } from '$lib/components/PrimaryButton/constants';
  import Preview from './Preview.svelte';
  import { SELECTABLE_STATUS } from './constants';
  import { snackbar } from '$lib/components/Snackbar/store';

  export let open = false;
  export let onClose = () => {};
  export let handleSave = () => {};

  // export let submissionId;
  export let data = {};
  export let updateStatus = () => {};

  let status = SELECTABLE_STATUS[0];

  let total = 0;
  let maxPoints = 0;

  function getMaxPoints(questions) {
    return (questions || []).reduce((acc, question) => acc + question.points, 0);
  }

  function calculateTotal(grades) {
    if (!grades) return 0;
    return Object.values(grades).reduce((acc, grade) => acc + parseInt(grade), 0);
  }

  function handleStatusChange() {
    updateStatus({
      submissionId: data.id,
      prevStatusId: data.status_id,
      nextStatusId: status.value,
      total
    });

    snackbar.success(`Submission updated to '${status.label}'`);
  }

  function setStatus(data) {
    status = SELECTABLE_STATUS.find((status) => status.value === data.status_id);
  }

  function getStatusColor(status) {
    // if (!status)
    return '';

    // switch (status.value) {
    //   case STATUS.SUBMITTED:
    //     return '';
    //   case STATUS.IN_PROGRESS:
    //     return 'text-white bg-primary-700';
    //   case STATUS.GRADED:
    //     return 'text-white bg-green-700';
    // }
  }

  onMount(() => {
    console.log('mounting');
  });

  $: total = calculateTotal(data.questionAnswerByPoint);
  $: maxPoints = getMaxPoints(data.questions);
  $: setStatus(data);
</script>

<Modal
  modalHeading={data.title}
  bind:open
  {onClose}
  width="w-4/5"
  containerClass="flex items-start"
>
  <div class="w-full">
    <Preview
      questions={Array.isArray(data.questions)
        ? data.questions.sort((a, b) => a.order - b.order)
        : []}
      questionnaireMetaData={{
        answers: data.answers || {},
        isFinished: true
      }}
      bind:grades={data.questionAnswerByPoint}
    />
  </div>
  <div class="ml-4 w-2/5 sticky top-0">
    <div class="border border-gray-300 rounded-md mt-2">
      <div
        class="hover:bg-gray-100 dark:bg-neutral-800 border-b border-t-0 border-l-0 border-r-0 border-gray-300 p-3"
      >
        <p class="dark:text-white font-bold text-lg">
          Details
          {#if data.isEarly}
            <span class="ml-2 text-sm badge rounded-sm px-2 bg-green-500 text-white"> early </span>
          {:else}
            <span class="ml-2 badge text-sm rounded-sm px-2 bg-red-500 text-white"> late </span>
          {/if}
        </p>
      </div>

      <div class="flex items-center text-sm p-3">
        <p class="dark:text-white font-bold w-2/5">Total grade</p>
        <p class="dark:text-white">{total} / {maxPoints}</p>
      </div>
      <!-- <div class="flex items-center text-sm p-3">
        <p class="dark:text-white font-bold w-1/2">Status</p>
        <div class="flex items-center">
          <p class="dark:text-white rounded-full w-5 h-5 bg-yellow-300 mr-2" />
          <p class="dark:text-white">Grading</p>
        </div>
      </div> -->
      <div class="flex items-center text-sm p-3">
        <p class="dark:text-white font-bold w-2/5">Student</p>
        {#if data.student}
          <img
            alt="Student avatar"
            class="block rounded-full h-6 w-6"
            src={data.student.avatar_url}
          />
          <p class="dark:text-white ml-2 text-sm">{data.student.fullname}</p>
        {/if}
      </div>
      <div class="flex items-center text-sm p-3">
        <p class="dark:text-white font-bold w-2/5">Status</p>
        <Select
          bind:value={status}
          options={SELECTABLE_STATUS}
          selectClassName={getStatusColor(status)}
          onChange={handleStatusChange}
          className="w-full"
        />
      </div>
      <div class="flex items-center justify-center w-full p-3">
        <PrimaryButton
          onClick={() => {
            handleSave(data);
          }}
          label="Submit Grades"
          variant={VARIANTS.CONTAINED_SUCCESS}
          className="py-3 px-8 w-full"
        />
      </div>
      <!-- <div class="flex items-center text-sm p-3">
        <p class="dark:text-white font-bold w-1/2">Teacher</p>
        <p class="dark:text-white">rotimi-best</p>
      </div> -->
    </div>
  </div>
</Modal>

<style>
  .badge {
    width: fit-content;
  }
</style>
