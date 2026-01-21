Class {
	#name : #LeJsonV4,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'newReader',
		'newWriter',
		'mutex'
	],
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #accessing }
LeJsonV4 class >> explicitClassNamesToMap [

	^ #(#AsyncFuturePendingTaskSignal #AsyncFutureSignal #BeaconLoggerSignal #BeaconSignal #BlBeaconTaskSignal #BlDevScripterSignal #BlDevScripterStepAboutToPlaySignal #BlDevScripterStepExceptionSignal #BlDevScripterStepFinishedSignal #BlDevScripterStepPulsationFinishedSignal #BlDevScripterStepPulsationTimeoutedSignal #BlDevScripterStepSignal #BlDragAndDropSignal #BlDragToSignal #BlElementDetachCompositionLayerSignal #BlElementNamedChildNotFoundSignal #BlElementNotFocusableSignal #BlElementOffsetCompositionLayerSignal #BlElementSignal #BlGotFocusSignal #BlImageCacheSignal #BlInfiniteDataSourceChangedSignal #BlInfiniteDataSourceItemsChangedSignal #BlInfiniteDataSourceSignal #BlInfiniteElementSignal #BlInfiniteLinearLayoutSignal #BlInfiniteLinearLayoutStateClearScrapSignal #BlInfiniteLinearLayoutStateSetScrapSignal #BlInfiniteRecyclerAboutToBindHolderForPositionSignal #BlInfiniteRecyclerAboutToRecycleInPoolSignal #BlInfiniteRecyclerAddedToAttachedScrapSignal #BlInfiniteRecyclerAddedToChangedScrapSignal #BlInfiniteRecyclerClearedAttachedScrapSignal #BlInfiniteRecyclerFetchHolderSignal #BlInfiniteRecyclerSignal #BlLostFocusSignal #BlMarkElementNeedsPaintSignal #BlNonUIProcessSignal #BlParallelUniverseDeferredActionAddedSignal #BlParallelUniverseHostSpaceCreatedSignal #BlParallelUniverseHostSpaceShownSignal #BlParallelUniverseHostStartRequestSignal #BlParallelUniverseHostStartedSignal #BlParallelUniverseOpenSpaceRequestSignal #BlParallelUniverseRunDeferredActionSignal #BlParallelUniverseSignal #BlParallelUniverseSpaceAddedSignal #BlParallelUniverseSpaceDetachSignal #BlParallelUniverseSpaceDispatchAddedToSceneSignal #BlParallelUniverseSpaceRootAssignedSignal #BlParallelUniverseSpaceSignal #BlParallelUniverseTryToRunDeferredActionsSignal #BlPulseStatSignal #BlRequestLayoutSignal #BlSpaceDetachedSignal #BlSpaceHostChangeSignal #BlSpaceRenderSignal #BlSpaceRenderedSignal #BlSpaceSignal #BlSpartaSpaceRendererInitializeSignal #BlTaskExecutionSignal #BlTextStylerRequestedSignal #BrAsyncElementFutureAboutToCancelPromiseSignal #BrAsyncElementFutureCompletedSuccessfullySignal #BrAsyncElementFutureReceivedSignal #BrAsyncElementFutureScheduledSignal #BrAsyncElementFutureSignal #BrAsyncElementFutureSkippedFutureSignal #BrAsyncElementFutureTerminatedUnsuccessfullySignal #BrAsyncElementFutureUpdateElementSignal #BrAsyncElementFutureUpdateElementSkippedSignal #BrAsyncElementPromiseElementUpdateSignal #BrAsyncElementPromiseInitializeElementErrorSignal #BrAsyncElementPromiseInitializeElementSignal #BrAsyncElementPromiseInitializeElementSuccessSignal #BrAsyncElementPromiseRequestUpdateSignal #BrAsyncElementPromiseSignal #BrCursorOutOfRangeSignal #BrElementUpdaterElementMayUpdateSignal #BrElementUpdaterEnqueuePostponedUpdateSignal #BrElementUpdaterEnqueueUpdateSignal #BrElementUpdaterPerformUpdateSignal #BrElementUpdaterSignal #BrTextEditorAttributesModifiedSignal #BrTextEditorCommandSignal #BrTextEditorHolderCommandSignal #BrTextEditorRecordDeselectionSignal #BrTextEditorRecordSelectionSignal #BrTextEditorResetCacheSignal #BrTextEditorSegmentAdornmentErrorSignal #BrTextEditorSegmentBuildSignal #BrTextEditorSegmentRecycleSignal #BrTextEditorSegmentSignal #BrTextEditorSegmentUpdateSignal #BrTextEditorSignal #BrTextStylerAsyncStrategySignal #BrTextStylerAsyncStylingFinished #BrTextStylerAsyncStylingStarted #BrTextStylerAsyncStylingSubmitted #ChromeIdleTimerSignal #ChromeReceivedMessageSignal #ChromeSignal #ChromeStringSignal #ContextStackSignal #CurrentProcessSignal #DAPMessageSignal #DummySignal #ExceptionSignal #GlutinEventSignal #GtAwsWebServiceCommandEndSignal #GtAwsWebServiceCommandSignal #GtAwsWebServiceCommandStartSignal #GtBeaconGenericLogSignal #GtBeaconLabelledLogSignal #GtBeaconLeJsonEncodingErrorSignal #GtBeaconMethodSignal #GtBeaconTypedLogSignal #GtCoderAddOnCreatedSignal #GtCoderAddOnSignal #GtCoderAddOnsComputationFinishedSignal #GtCoderAddOnsComputationSignal #GtCoderAddOnsComputationStartedSignal #GtCoderEvaluationStatusChangedSignal #GtCoderEvaluationStatusShowNotificationSignal #GtCoderIncomingEvaluationStatusSignal #GtCompletionApplyPreviewSignal #GtCompletionCancelPreviewSignal #GtConnectorBasicEventSignal #GtConnectorBasicSignal #GtConnectorContextEventSignal #GtConnectorEventSignal #GtDeDockerLogEntrySignal #GtDebuggerPharoMethodIndicatorSignal #GtDebuggerSignal #GtDebuggerStackElementBindCoderViewModelSignal #GtDebuggerStackElementFirstNonFilteredContextFoundSignal #GtDebuggerStackElementFirstNonFilteredContextPreloadSignal #GtDebuggerStackElementOnStackChangedSignal #GtDebuggerStackElementOnUpdateContentSignal #GtDebuggerStackElementOnUpdateDebuggerSignal #GtDebuggerStackElementOnUpdateSessionSignal #GtDependencyAnalyzerBrokenBaselineSignal #GtEpNilCommentSignal #GtExamplesReportExceptionSignal #GtExamplesReportRetrySignal #GtExamplesReportRunClassSignal #GtExamplesReportRunExampleSignal #GtExamplesReportRunPackageSignal #GtExamplesReportSignal #GtFilterItemsChangedSignal #GtFilterSignal #GtGemStoneBeaconSignal #GtGemStoneClassCategoryChangeCodeSyncSignal #GtGemStoneClassCodeSyncSignal #GtGemStoneClassCommentCodeSyncSignal #GtGemStoneClassDefinitionCodeSyncSignal #GtGemStoneClassRemovalCodeSyncSignal #GtGemStoneClassRenameCodeSyncSignal #GtGemStoneCodeSyncSignal #GtGemStoneCodeSyncStateSignal #GtGemStoneIgnoredCodeSyncSignal #GtGemStoneKeepAlivePollCompletedSignal #GtGemStoneKeepAlivePollSignal #GtGemStoneKeepAlivePollStartedSignal #GtGemStoneKeepAliveSessionCleanSignal #GtGemStoneKeepAliveSessionEndSignal #GtGemStoneKeepAliveSessionErrorSignal #GtGemStoneKeepAliveSessionModifiedSignal #GtGemStoneKeepAliveSessionPollStartedSignal #GtGemStoneKeepAliveSessionSignal #GtGemStoneKeepAliveSignal #GtGemStoneMethodCodeSyncSignal #GtGemStoneSessionAutoCommitSignal #GtGemStoneSessionEvaluationDeliverySignal #GtGemStoneSessionEvaluationDeserializeResultSignal #GtGemStoneSessionEvaluationExecutionEndSignal #GtGemStoneSessionEvaluationExecutionSignal #GtGemStoneSessionEvaluationExecutionStartSignal #GtGemStoneSessionEvaluationPerformExecutionStartSignal #GtGemStoneSessionEvaluationPromiseWaitSignal #GtGemStoneSessionEvaluationResolveBindingsSignal #GtGemStoneSessionEvaluationScriptExecutionStartSignal #GtGemStoneSessionEvaluationSignal #GtGemStoneSessionSignal #GtGitCliContextStackSignal #GtGitCliSignal #GtGradCircleLayoutRadiusSignal #GtGradHierarchicalLayoutCurrentComponentSignal #GtGradHierarchicalLayoutInitialRanksSignal #GtGradHierarchicalLayoutLayeringStageOutputSignal #GtGradKamadaKawaiDistanceMatrixSignal #GtGradKamadaKawaiInitialPositionSetSignal #GtGradKamadaKawaiLayoutDeltasSignal #GtGradProcessingTreeSignal #GtGradTreeLayoutCorrectionSignal #GtGradTreeLayoutNodeProcessingFinishedSignal #GtGradTreeLayoutNodeProcessingStartedSignal #GtGradTreeLayoutOffsetSetSignal #GtInspectorSampleBOneForwardObjectSignal #GtInspectorSelectTabSignal #GtJustContextStackSignal #GtLSPServerIOSignal #GtLSPServerInputSignal #GtLSPServerOutputSignal #GtLlmFunctionCallAboutToBePerformedSignal #GtLlmFunctionCallPerformedSignal #GtLlmFunctionCallSignal #GtLlmStylerSignal #GtLoadItemsStackSignal #GtMondrianEdgeNotCreated #GtMyExampleBeaconSignal #GtMyExampleBeaconStartSignal #GtMyExampleBeaconStopSignal #GtMyExampleLabelledBeaconSignal #GtNetworkNoProxySetSignal #GtNetworkProxyInvalidEnvironmentVariableValueSignal #GtNetworkProxySetSignal #GtNetworkProxySignal #GtNetworkProxyUndefinedEnvironmentVariableSignal #GtNotificationIcebergCredentialsSignal #GtPharoCodersStreamChangedSignal #GtPharoExampleSuiteMediatorSignal #GtPharoFlushChangesFileSignal #GtPharoMethodCoderAddedSignal #GtPharoMethodCoderAnnouncementSignal #GtPharoMethodCoderCompiledSignal #GtPharoMethodCoderModifiedSignal #GtPharoMethodCoderRemovedSignal #GtPharoNewCodersStreamSignal #GtPharoStreamingMethodsChangedSignal #GtPharoStreamingMethodsCoderElementSignal #GtPharoStreamingMethodsFiltersElementStencilDefaultChangedSignal #GtPharoStreamingMethodsScrollToTargetSignal #GtPharoSubscribedToMethodCoderSignal #GtPharoUserMessageSignal #GtPhlowApplyToolSelectionSignal #GtPhlowForwarderFutureElementSignal #GtPhlowStoreToolSelectionSignal #GtRemoteRunnerAnnouncement #GtRemoteRunnerSignal #GtRemoteRunnerTraceAnnouncement #GtRlActionExecutionCompletedSignal #GtRlActionExecutionSignal #GtRlActionExecutionStartedSignal #GtRlActionSignal #GtRlClonerBaselineLoadCompletedSignal #GtRlClonerBaselineLoadSignal #GtRlClonerBaselineLoadStartedSignal #GtRlClonerBaselinePackageLoadSignal #GtRlClonerBaselineSignal #GtRlClonerBaselineSkipLoadSignal #GtRlCreateReleaseActionSignal #GtRlLoaderDirectiveActionExecutionCompletedSignal #GtRlLoaderDirectiveActionExecutionStartedSignal #GtRlLoaderDirectiveActionSignal #GtRlProjectLinkWithRepositorySignal #GtRlProjectReleaseStrategySignal #GtRlProjectReleaseStructureSignal #GtRlReleaseConfigurationSignal #GtRlReleaserSignal #GtRlRepositoryActiveReleaseVersionSignal #GtRlRepositoryPassiveReleaseVersionSignal #GtRrAnnouncementQueueDeliveryAnnouncement #GtRrAnnouncementQueueDeliveryCompletedSignal #GtRrAnnouncementQueueDeliveryInitiatedSignal #GtRrAnnouncementQueuePullCompletedSignal #GtRrAnnouncementQueuePullInitiatedSignal #GtRrAnnouncementQueuePullSignal #GtRrAnnouncementQueueSignal #GtRrChangesSyncRetrievalCompletedSignal #GtRrChangesSyncRetrievalSignal #GtRrChangesSyncRetrievalStartingSignal #GtRrCodeSyncApplyChangeCompletedSignal #GtRrCodeSyncApplyChangeSignal #GtRrCodeSyncApplyChangeStartingSignal #GtRrCodeSyncJobSignal #GtRrCodeSyncSignal #GtRrExampleStringSignal #GtRrJobAnnouncement #GtRrJobCancelledAnnouncement #GtRrJobCompletedAnnouncement #GtRrJobShutdownSignal #GtRrJobStartedAnnouncement #GtRrJobStartupAndShutdownSignal #GtRrJobStartupSignal #GtRrJobTerminatedAnnouncement #GtRrMessageStatsSignal #GtRrMqQueueTaskCompletedSignal #GtRrMqQueueTaskSignal #GtRrMqQueueTaskStartingSignal #GtRrMqTaskMissingSignal #GtRrNextTaskCompletedSignal #GtRrNextTaskFinishedWithWorkerSignal #GtRrNextTaskSignal #GtRrNextTaskStartingSignal #GtRrNextTaskWorkerNotRegisteredSignal #GtRrRegisterWorkerCompletedSignal #GtRrRegisterWorkerRejectedSignal #GtRrRegisterWorkerSignal #GtRrRegisterWorkerStartingSignal #GtRrResultProcessingErrorAnnouncement #GtRrStatusMessageChangedAnnouncement #GtRrStompMqCommandCallbackCompletedSignal #GtRrStompMqCommandCallbackSignal #GtRrStompMqCommandCallbackStartingSignal #GtRrStompMqSendMessageCompletedSignal #GtRrStompMqSendMessageSignal #GtRrStompMqSendMessageStartingSignal #GtRrStompMqTaskCallbackCompletedSignal #GtRrStompMqTaskCallbackSignal #GtRrStompMqTaskCallbackStartingSignal #GtRrStopRegisteredWorkerCompletedSignal #GtRrStopRegisteredWorkerSignal #GtRrStopRegisteredWorkerStartingSignal #GtRrStopRegisteredWorkersCompletedSignal #GtRrStopRegisteredWorkersSignal #GtRrStopRegisteredWorkersStartingSignal #GtRrSyslogSignal #GtRrTaskAnnouncement #GtRrTaskCompletedAnnouncement #GtRrTaskContext #GtRrTaskDoneCompletedSignal #GtRrTaskDoneSignal #GtRrTaskDoneStartingSignal #GtRrTaskFailedAnnouncement #GtRrTaskFinishedAnnouncement #GtRrTaskStartedAnnouncement #GtRrTimeoutAnnouncement #GtRrTimeoutCompletedAnnouncement #GtRrTimeoutScheduledAnnouncement #GtRrTimeoutStartedAnnouncement #GtRrWorkerAnnouncement #GtRrWorkerApplyChangeCompletedSignal #GtRrWorkerApplyChangeSignal #GtRrWorkerApplyChangeStartingSignal #GtRrWorkerApplyChangesCompletedSignal #GtRrWorkerApplyChangesSignal #GtRrWorkerApplyChangesStartingSignal #GtRrWorkerChangesSignal #GtRrWorkerChangesSyncAnnouncement #GtRrWorkerChangesSyncErrorAnnouncement #GtRrWorkerChangesSyncHaveEventsAnnouncement #GtRrWorkerChangesSyncStartAnnouncement #GtRrWorkerChangesSyncedAnnouncement #GtRrWorkerCheckCompletedSignal #GtRrWorkerCheckSignal #GtRrWorkerCheckStartingSignal #GtRrWorkerCliCompletedSignal #GtRrWorkerCliSignal #GtRrWorkerCliStartingSignal #GtRrWorkerCommandAnnouncement #GtRrWorkerCommandCompletedAnnouncement #GtRrWorkerCommandStartedAnnouncement #GtRrWorkerConnection #GtRrWorkerControlChannelRegisteredAnnouncement #GtRrWorkerFilterChangesCompletedSignal #GtRrWorkerFilterChangesSignal #GtRrWorkerFilterChangesStartingSignal #GtRrWorkerHeartbeatCompletedSignal #GtRrWorkerHeartbeatSignal #GtRrWorkerHeatbeatStartingSignal #GtRrWorkerOperationAnnouncement #GtRrWorkerOperationShutdownAnnouncement #GtRrWorkerOperationSignal #GtRrWorkerRegisterCompletedSignal #GtRrWorkerRegisterSignal #GtRrWorkerRegisterStartingSignal #GtRrWorkerRegisteredAnnouncement #GtRrWorkerRegistrationRefusedAnnouncement #GtRrWorkerReplacedAnnouncement #GtRrWorkerResponseConfirmedSignal #GtRrWorkerResponseErrorSignal #GtRrWorkerResponseSentSignal #GtRrWorkerResultEntry #GtRrWorkerRetrieveChangesCompletedSignal #GtRrWorkerRetrieveChangesSignal #GtRrWorkerRetrieveChangesStartingSignal #GtRrWorkerTaskCompletedSignal #GtRrWorkerTaskProcessErrorAnnouncement #GtRrWorkerTaskSignal #GtRrWorkerTaskStartingSignal #GtRrWorkerTimeoutAnnouncement #GtRrWorkerTraceAnnouncement #GtRrWorkerUnregisteredAnnouncement #GtRrWorkerWaitForTaskAnnouncement #GtSourceCoderProcessInDebuggerSignal #GtStrictSymbolEqualityArgumentSignal #GtStylerErrorSignal #GtTextualCoderEditorElementAddedToSceneGraphSignal #GtTextualCoderEditorElementAttachedSpaceSignal #GtTextualCoderEditorElementDetachedSpaceSignal #GtTextualCoderEditorElementRemovedFromSceneGraphSignal #GtTextualCoderEditorElementSignal #GtTextualCoderEditorElementUpdateCursorsSignal #GtTextualCoderEditorElementUpdateStateSignal #GtTextualCoderEditorElementUpdateTextSignal #GtVirtualMachineDebugSignal #GtVirtualMachineErrorSignal #GtVirtualMachineGenericSignal #GtVirtualMachineInfoSignal #GtVirtualMachineLevelSignal #GtVirtualMachineSignal #GtVirtualMachineTraceSignal #GtVirtualMachineWarningSignal #LanguageLinkBrokerHandleMessage #LanguageLinkBrokerSendMessage #LanguageLinkCommandSignal #LanguageLinkCommunicationsSignal #LanguageLinkDeliverCommandSignal #LanguageLinkEventSignal #LanguageLinkMsgPackPharoBrokerSignal #LanguageLinkSendCommandSignal #LanguageLinkSignal #LanguageLinkSocketErrorSignal #LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal #LeDatabaseSidebarGroupedListScrolledToIndexSignal #LeDatabaseSidebarGroupedListUpdateSelectionSignal #LeLocalStoreSignal #LePathFinderSignal #LeReferenceMaintenanceSignal #LeReloadOutOfDateReasonSignal #LeReloadReasonSignal #LeReloadUpToDateReasonSignal #LeTextSnippetUpdateTextAssignSignal #LeTextSnippetUpdateTextScheduleSignal #LeTextSnippetUpdateTextSignal #LeZincSignal #LlEsCheckServerReadyCompletedSignal #LlEsCheckServerReadySignal #LlEsCheckServerReadyStartingSignal #LlEsConnectCompletedSignal #LlEsConnectSignal #LlEsConnectStartingSignal #MethodStackSignal #PharoLinkBadResponseSignal #PharoLinkErrorRequestSignal #PharoLinkEvalSignal #PharoLinkNetworkErrorSignal #PharoLinkRegistryUnknownIdSignal #PharoLinkRequestSignal #PharoLinkResponseSignal #PharoLinkServerSignal #PharoLinkSignal #SkiaPerformanceSignal #SkiaSignal #SkiaStringToTextRunBoundsAsRectangleSignal #SkiaStringToTextRunComputeGlyphsSignal #SkiaStringToTextRunGlyphsAsByteArraySignal #SkiaStringToTextRunSignal #SkiaStringToTextRunUtfConvertionSignal #StampHeartbeatSignal #StampSignals #StreamLoggerFlusherErrorSignal #StringSignal #TaskAtErrorSignal #TelemetrySignal #ThisContextSignal #WrapperSignal #ZnLogEventSignal)
]

{ #category : #loading }
LeJsonV4 class >> loadFile: aFileReference [

	^ self uniqueInstance loadFile: aFileReference
]

{ #category : #private }
LeJsonV4 >> allClassMappingsFor: aNeoJSONMapper [
	"Add the class mappings for all supported classes.
	Classes are identified either by implementing #leJsonV4Name or being in the #explicitClassNamesToMap list."

	"Add classes with #leJsonV4Name"
	(SystemNavigation default allImplementorsOf: #leJsonV4Name) do: [ :method | 
		| jsonName |
		method methodClass isMeta ifTrue: 
			[ jsonName := method
					gtValueWithReceiver: method methodClass soleInstance
					possibleArguments: #().
			jsonName ifNotNil: 
				[ method methodClass instanceSide leJsonV4MappingFor: aNeoJSONMapper ] ] ].

	"Add classes in #explicitClassNamesToMap"
	self explicitClassesToMap do: [ :cls |
		| jsonName |
		jsonName := cls name asString.
		jsonName at: 1 put: jsonName first asLowercase.
		cls leJsonV4MappingFor: aNeoJSONMapper named: jsonName ].
]

{ #category : #testing }
LeJsonV4 >> canSerialize: anObject [
	"Answer a boolean indicating whether the supplied class can be serialised"

	^ anObject class class includesSelector: #leJsonV4Name
]

{ #category : #'api - serializing' }
LeJsonV4 >> deserialize: aStream [
	"Deserialise the supplied stream"
	| object |

	object := self newReader 
		on: aStream;
		next.
	"If the deserialised object is a Dictionary, the __schema should be removed"
	object isDictionary ifTrue:
		[ object removeKey: '__schema' ifAbsent: [ ] ].

	^ object
]

{ #category : #private }
LeJsonV4 >> explicitClassesToMap [

	^ self class explicitClassNamesToMap collect: [ :name |
		self class environment classOrTraitNamed: name ]
]

{ #category : #initialization }
LeJsonV4 >> initialize [

	super initialize.
	mutex := Mutex new.
]

{ #category : #loading }
LeJsonV4 >> loadFile: aFileReference [

	^ aFileReference asFileReference readStreamDo: [ :stream |
		self deserialize: stream ]
]

{ #category : #initialization }
LeJsonV4 >> newReader [ 
	newReader ifNil: [ mutex critical: [ | reader |
		reader := LeJsonV4Reader new.
		self allClassMappingsFor: reader.
		newReader := reader ] ].
	^ newReader copy
]

{ #category : #initialization }
LeJsonV4 >> newWriter [ 

	newWriter ifNil: [ mutex critical: [ | writer |
		writer := LeJsonV4Writer new.
		self allClassMappingsFor: writer.
		newWriter := writer ] ].
	^ newWriter copy
]

{ #category : #private }
LeJsonV4 >> schemaFor: aKey [
	"Answer the schema (class) for the given key"

	^ LeModel allSubclasses detect: 
		[ :each | each leJsonV4Name = aKey ].
]

{ #category : #accessing }
LeJsonV4 >> serialize: aLeModel [

	^ String streamContents: [ :stream | 
		  self serialize: aLeModel on: stream prettyPrint: false ]
]

{ #category : #'api - serializing' }
LeJsonV4 >> serialize: aLeModel on: aStream prettyPrint: aBoolean [
	"Serialise the supplied object. aLeModel is a subclass of LeModel"

	self newWriter 
		on: aStream;
		prettyPrint: aBoolean;
		nextPut: aLeModel.

]

{ #category : #accessing }
LeJsonV4 >> serializePretty: aLeModel [

	^ String streamContents: [ :stream | 
		  self serialize: aLeModel on: stream prettyPrint: true ]
]
